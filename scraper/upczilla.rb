
require_relative '../lib/strategy'
class Upczilla  < Strategy

    def scrape(code)
        begin
            description = image_url = ''
            valid = false
            url = "https://www.upczilla.com/item/#{code}/"
            html = HTTParty.get(url, :verify => false)
            doc = Nokogiri::HTML(html)
            description = doc.css('.producttitle').text
            unless description.empty?
                item_featured = doc.css('.item.featured')
                imgdiv = item_featured.css('.imgdiv')
                imgs = imgdiv.css('img')
                img =  imgs[0]
                image_url = img.attributes['src'].value
                valid = true;
            end
        rescue => error 
            p "ERROR "*5
            p url
            p error
            pp error.backtrace
        end
        
        ret = {code:code, valid:valid, description: description, image_url: image_url,provider: File.basename(__FILE__)}
        return ret 
    end
end

