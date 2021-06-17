require_relative '../lib/strategy'

class BarcodeDatabase < Strategy

    def scrape(code)
        description = image_url = ''
        valid = false
        html = HTTParty.get("https://barcodesdatabase.org/barcode/#{code}")
        doc = Nokogiri::HTML(html)
        container =  doc.css("#internal-db.well")

        unless container.empty?
            description = container.css("table").css("td")[5].text 
            image_url =  container.css('img')[0].attributes['src'].text
            valid = true;
        end
        res = {code:code, valid:valid, description: description, image_url: image_url,provider:File.basename(__FILE__)}
        return res 
    end
    
end
