module GACollectorPusher
  class Instance
    attr_accessor :cid, :timeout, :open_timeout

    def initialize cid: nil, backup_cid: nil, timeout: 10, open_timeout: 10
      self.cid = cid || backup_cid
      self.timeout = timeout
      self.open_timeout = open_timeout
    end

    def add_event category: nil, action: nil, label: nil, value: nil, utmni: false
      @params = {
        v: GOOGLE_ANALYTICS_SETTINGS[:version], 
        tid: GOOGLE_ANALYTICS_SETTINGS[:tracking_code], 
        cid: self.cid, 
        t: "event", 
        ec: category, 
        ea: action
      }
      send_to_ga
    end

    def add_transaction transaction_id: nil, total: nil, store_name: nil, tax: nil, shipping: nil, city: nil, region: nil, country: nil
      @params = {
        v: GOOGLE_ANALYTICS_SETTINGS[:version], 
        tid: GOOGLE_ANALYTICS_SETTINGS[:tracking_code], 
        cid: self.cid, 
        t: "transaction",
        ti: transaction_id,
        tr: total,
      }
      send_to_ga
    end

    def add_item transaction_id: nil, item_sku: nil, price: nil, quantity: nil, name: nil, category: nil
      @params = {
        v: GOOGLE_ANALYTICS_SETTINGS[:version], 
        tid: GOOGLE_ANALYTICS_SETTINGS[:tracking_code], 
        cid: self.cid, 
        t: "item", 
        ti: transaction_id,
        in: name,
        ip: price,
        iq: quantity,  
        ic: item_sku,
        iv: category
      }
      send_to_ga
    end

    private
      def send_to_ga
        puts GOOGLE_ANALYTICS_SETTINGS
        puts @params.inspect
        params = @params.stringify_keys
        RestClient.get 'https://www.google-analytics.com/collect', params: params, timeout: self.timeout, open_timeout: self.open_timeout
      end
  end
end
