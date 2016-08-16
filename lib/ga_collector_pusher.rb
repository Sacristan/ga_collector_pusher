require 'rest-client'
require 'active_support/core_ext'
require 'ga_collector_pusher/instance'
require 'ga_collector_pusher/config'

module GACollectorPusher
  def self.new
    GACollectorPusher::Instance.new(cid: nil, backup_cid: nil, timeout: 10, open_timeout: 10)
  end
end
