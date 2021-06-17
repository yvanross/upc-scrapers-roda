require 'rspec-roda'

ENV['PORT']="3000"
ENV['UPC_LOOKUP_GATEWAY_PORT']="6300"
ENV['HEARTBEAT_FREQUENCY']="1"
ENV["RACK_ENV"]="test"

RSpec.configure do |c|
    c.exclusion_filter = {:real_http => true}
end