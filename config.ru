# cat config.ru
require "roda"
# plugin :json #https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/Json.html
Roda.plugin :json

class App < Roda
  route do |r|
    # GET / request
    r.root do
      r.redirect "/hello"
    end

    r.get 'login' do 
        {'token' => "#{r.params['user']['device_token']}"}
    end

    r.post 'reset_password' do
      {'token' => "#{r.params['user']['device_token']}"}
    end 

    # /hello branch
    r.on "hello" do
      # Set variable for all routes in /hello branch
      @greeting = 'Hello'

      # GET /hello/world request
      r.get "world" do
        "#{@greeting} world!"
      end

      # /hello request
      r.is do
        # GET /hello request
        r.get do
          "#{@greeting}!"
        end

        # POST /hello request
        r.post do
          puts "Someone said #{@greeting}!"
          r.redirect
        end
      end
    end
  end
end

run App.freeze.app