# require 'uri'
# require 'net/http'
# docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management

require 'date'
require 'bunny'

class Heartbeat

    def initialize()

        raise StandardError.new "PORT environement variable not defined" if ENV['PORT'].nil?
        raise StandardError.new "UPC_LOOKUP_GATEWAY_PORT environement variable not defined" if ENV['UPC_LOOKUP_GATEWAY_PORT'].nil?
        raise StandardError.new "HEARTBEAT_FREQUENCY environement variable not defined" if ENV['HEARTBEAT_FREQUENCY'].nil?

        p "X"*70
        puts ENV['RABBIT']
        connection = Bunny.new(ENV['RABBIT'])     
        connection.start
        channel = connection.create_channel
        @channel = connection.create_channel
        @queue = channel.queue('heartbeat')
    end

    def publish 
        begin
            p "publish #{ENV['PORT']} to #{@queue.name}"
            @channel.default_exchange.publish(ENV['PORT'], routing_key: @queue.name)
        rescue => error 
            p "ERROR: #{error.message}"
        end
    end

    def start()
        # gateway_port = ENV['UPC_LOOKUP_GATEWAY_PORT']
     
        queue = channel.queue('heartbeat')

        fork do
            while true
                begin
                    # p ENV['HEARTBEAT_FREQUENCY'].to_i
                    now = DateTime.now
                    # p "#{now} #{ENV['SCRAPER']} call: #{uri}"
                     # res = Net::HTTP.get_response(uri)
                    # p res
                    # p res.code
                    # p res.body
                    # p res.message
                    # if res.code == "200"
                    #     p "#{now} #{ENV['SCRAPER']} upc-lookup-gateway confirm heartbeat processing" 
                    # else
                    #     p "#{now} #{ENV['SCRAPER']} gateway was not able to process heartbeat" if res.code != "200"
                    # end
                rescue => error 
                  pp error.backtrace
                    pp "#{now}  #{ENV['SCRAPER']}: #{error.message}"
                    pp "#{now}  #{ENV['SCRAPER']} gateway is probably not running for uri: #{uri}"
                ensure
                    sleep ENV['HEARTBEAT_FREQUENCY'].to_i
                end
            end
        end
        p "END FORK"
    end

end



 # https://www.toptal.com/ruby/ruby-concurrency-and-parallelism-a-practical-primer
        # fork do
        #   while true
        #   heartbeat = Heartbeat.new(6300)
        #   heartbeat.send()
        #   sleep(1)
        #   end
        # end
