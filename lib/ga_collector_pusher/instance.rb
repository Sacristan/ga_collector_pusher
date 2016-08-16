# GA Measurement protocol DOCS:
# https://developers.google.com/analytics/devguides/collection/protocol/v1/parameters
# https://developers.google.com/analytics/devguides/collection/protocol/v1/devguide?hl=en#social

module GACollectorPusher
  class Instance
    attr_accessor :cid, :timeout, :open_timeout

    def initialize cid: nil, backup_cid: nil, timeout: 10, open_timeout: 10
      self.cid = cid || backup_cid
      self.timeout = timeout
      self.open_timeout = open_timeout
    end

    def add_page_view hostname: nil, page: nil, title: nil
      @params = {
        t: "pageview",
        dh: hostname,
        dp: page,
        dt: title
      }

      send_to_ga
    end

    def add_event category: nil, action: nil, label: nil, value: nil, utmni: false
      @params = {
        t: "event",
        ec: category,
        ea: action
      }

      send_to_ga
    end

    def add_transaction transaction_id: nil, total: nil, store_name: nil, tax: nil, shipping: nil, city: nil, region: nil, country: nil, currency: "EUR"
      @params = {
        t: "transaction",
        ti: transaction_id,
        tr: total.round(2),
        cu: currency
      }

      send_to_ga
    end

    def add_item transaction_id: nil, item_sku: nil, price: nil, quantity: nil, name: nil, category: nil, currency: "EUR"
      @params = {
        t: "item",
        ti: transaction_id,
        in: name,
        ip: price.round(2),
        iq: quantity.to_i,
        ic: item_sku,
        iv: category,
        cu: currency
      }

      send_to_ga
    end

    def add_social action: nil, network: nil, target: nil
      @params = {
        t: "social",
        sa: action,
        sn: network,
        st: target
      }

      send_to_ga
    end

    #convert bool to integer
    def add_exception description: nil, is_fatal: false
      is_fatal_int = is_fatal ? 1 : 0

      @params = {
        t: "exception",
        exd: description,
        exf: is_fatal_int
      }

      send_to_ga
    end

    private
      def mandatory_fields
        {
          v: GOOGLE_ANALYTICS_SETTINGS[:version],
          tid: GOOGLE_ANALYTICS_SETTINGS[:tracking_code],
          cid: self.cid
        }
      end

      def send_to_ga
        @params.merge! mandatory_fields

        begin
          response = RestClient.post 'http://www.google-analytics.com/collect', params: @params, timeout: self.timeout, open_timeout: self.open_timeout
          puts "GACollectorPusher Sent params: #{@params.inspect}. Response from GA: #{response.to_s}" if GACollectorPusher::Config.verbose

          if (200..207).to_a.include? response.code
            status = "sent"
          else
            raise "GACollectorPusher received non 20x status from GA for #{@params}" if GACollectorPusher::Config.paranoid
            status = "error"
          end

        rescue => error
          response = error.inspect
          puts "GACollectorPusher error: #{response}" if GACollectorPusher::Config.verbose
          status = "error"
        end

        return {status: status, params: @params, response: response}
      end
  end
end
