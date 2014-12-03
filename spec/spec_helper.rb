require 'bundler/setup'
Bundler.setup

require "ga_collector_pusher"
require "tests/add_event_spec"

RSpec.configure do |config|
  # some (optional) config here
end