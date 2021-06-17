require_relative '../lib/strategy'

class GoogleShopping < Strategy

    def scrape(code)
        description = image_url = ''
        valid = false
        url = "https://www.google.com/search?q=#{code}&safe=active&source=lnms&tbm=shop"
        html = HTTParty.get(url, :verify => false)
        doc = Nokogiri::HTML(html)
        unless doc.text.include? "did not match any shopping results"
            description = doc.css('a').text.sub('GoogleAllImagesMapsVideoNewsBooksAbout','').sub('Sign inSearch settingsPrivacyTerms','').strip()
            image_url= doc.css('img')[1].attributes['src'].value
            valid = true;
        end
        res = {code:code, valid:valid, description: description, image_url: image_url,provider: File.basename(__FILE__)}
        return res
    end
end

