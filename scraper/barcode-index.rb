require_relative '../lib/strategy'

class BarcodeIndex < Strategy
    def scrape(code)
        description = image_url = ''
        valid = false
        url = "https://barcodeindex.com/upc/#{code}"
        html = HTTParty.get(url, :verify => false)
        doc = Nokogiri::HTML(html)
        unless doc.text.include? "Not Found"
            description = doc.css('h2').text.sub('Barcode for ','')
            image_url = doc.css('.card-image')[0].css('img')[0].attributes['src'].value
            valid = true;
        end
        res = {code:code, valid:valid, description: description, image_url: image_url,provider: File.basename(__FILE__)}
        return res 
    end
end

