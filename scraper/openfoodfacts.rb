require 'uri'
require 'net/http'
require_relative '../lib/strategy'

class OpenFoodFacts < Strategy

    def scrape(code)
        description = image_url = ''
        valid = false
        uri = URI("https://world.openfoodfacts.org/product/#{code}")
        res = Net::HTTP.get_response(uri)
        if res.code == "301"
            uri = URI("https://world.openfoodfacts.org#{res['location']}")
            res = Net::HTTP.get_response(uri)
        end

        if res.code == "200"
            doc = Nokogiri::HTML(res.body)
            no_product = doc.text.include? "No product listed for barcode" 
            invalid = doc.text.include? "Invalid barcode"
            no_product_or_invalid = no_product || invalid
            unless  no_product_or_invalid
                description =  doc.css('h1').text

                image_box_front = doc.css('#image_box_front').css('img')[0]
                image_url = image_box_front.attributes['src'].value
                valid = true;
            end    
        end
        res = {code:code, valid:valid, description: description, image_url: image_url,provider: File.basename(__FILE__)};
        pp res
        return res
    end
end




