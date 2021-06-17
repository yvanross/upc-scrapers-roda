# ENV['SCRAPER'] = 'Upczilla'
# require_relative '../../app.rb'
# require_relative '../spec_helper'

# RSpec.describe App, roda: :app do
#   before(:each) do
#   end
  
#     describe '/' do
#       before { get '/' }
  
#       it { is_expected.to be_successful }
#       its(:body) { is_expected.to eq "{\"name\":\"upc-scraper-upczilla-com-roda\"}" }
#     end


#     describe '/valid item' do
#       before {get '/756619009407'}
#       it {is_expected.to be_successful}
#       its(:body) { 
#         expect(res[:code]).to eq"756619009407\"")
#         expect(res[:valid]).to eq:true")
#         expect(res[:description]).to eq\"Elenco - XMH-218 Solid Hook-Up Wire Kit 6 Colors in a dispenser box # WK-106")
#         expect(res[:image_url]).to eq\"https://www.upczilla.com/wp-content/plugins/storeminator/cache/images/756/619/009/756619009407.webp\"")
#         expect(res[:provider]).to eq "upczilla-com\"")
#       }
#     end 

#     describe '/invalid item' do
#       before {get '/065633128507333336666'}
#       # it {is_expected.to not be_successful}
#       its(:body) { 
#         expect(res[:code]).to eq"065633128507333336666\"")
#         expect(res[:valid]).to eq:false")
#         expect(res[:description]).to eq\"")
#         expect(res[:image_url]).to eq\"\"")
#         expect(res[:provider]).to eq "upczilla-com\"")
#       }
#     end
    
# end 