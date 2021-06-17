require_relative '../lib/strategy'

class ItemDb < Strategy

    def scrape(code)
        description = image_url = ''
        valid = false
        url = "https://www.upcitemdb.com/upc/#{code}"
        html = HTTParty.get(url, :verify => false)
        doc = Nokogiri::HTML(html)
        upcdetail =  doc.css("div.upcdetail")
        unless upcdetail.empty?
            image_url = upcdetail.css('img.product')[0].attributes['src'].value
            description = upcdetail.css('div.cont').css('ol.num').css('li')[0].text
            valid = true;
        end

        res = {code:code, valid:valid, description: description, image_url: image_url, provider:File.basename(__FILE__)}
        return res 
    end
    
end