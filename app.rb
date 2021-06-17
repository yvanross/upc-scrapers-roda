require_relative 'env'
require_relative  './scraper/barcode-database'
require_relative  './scraper/barcode-index'
require_relative  './scraper/buycott'
require_relative  './scraper/google-shopping'
require_relative  './scraper/itemdb'
require_relative  './scraper/openfoodfacts'

puts "App "*7

class App < Roda
  plugin :json # TODO: add oj serialization
  plugin :multi_route
  plugin :all_verbs
  plugin :not_found
  plugin :error_handler
  attr_writer :strategy

  begin
    Object.const_get(ENV['SCRAPER'])
  rescue => error
    raise  "#{ENV['SCRAPER']} is not a valid scraper class name" 
  end

  # def initialize(env)
  #   super(env)
  #   p '-'*60
  #   pp env
  #   p '='*60
  #   pp ENV
  #   @strategy = Object.const_get(ENV['SCRAPER']).new
  # end


  route do |r|
    r.root {
      p "#{ENV['SCRAPER']}:upc-scrapers-roda/"
      {
        name: ENV['SCRAPER']
      }
    }

    r.get 'start' do
      p "#{ENV['SCRAPER']}:upc-scrapers-roda/start"
      @@heartbeat.start()
    end
    
    r.get String do |code|
      p "#{ENV['SCRAPER']}:upc-scrapers-roda/#{code}"
      res = @strategy.scrape(code)
      res
    end
  end
 
  not_found do
    {
      error: 404,
      error_message: "404 - Not Found"
    }
  end

  error do |err|
    case err
    # catch a proper error instead of nil...
    when nil
    # when CustomError
    #   "ERR" # like so
    else
      puts "-"*70
      puts "ERROR: upc- scraper-world-openfoodfacts-org-roda"
      puts err
      puts "-"*70
      {
        error: 500,
        error_message: "500 - Internal Server Error - check logs for details - error: '#{err.class} - #{err.message}'"
      }
    end
  end
end
