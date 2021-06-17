require_relative '../lib/strategy'

class Buycott < Strategy

    def scrape(code)
        description = image_url = ''
        valid = false
        url = "https://www.buycott.com/upc/#{code}"
        html = HTTParty.get(url, :verify => false)
        # File.open("data.html", 'w') { |file| file.write(html) }
        # html = File.open("data.html")
        doc = Nokogiri::HTML(html)
        unless doc.text.include? "Sign Up"
            description =  doc.css('h2').text
            image_url = doc.css('.header_image').css('img')[0].attributes['src'].text
            valid = true;
        end
        res = {code:code, valid:valid, description: description, image_url: image_url,provider: File.basename(__FILE__)}
        return res 
    end
end
