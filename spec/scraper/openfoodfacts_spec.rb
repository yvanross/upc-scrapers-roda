require_relative '../../scraper/openfoodfacts'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'

RSpec.describe 'openfoodfacts' do
  describe "Environement variables" do
    before(:each) do
      @scraper = OpenFoodFacts.new
    end

    it '/invalid item', :real_http=>true do
      res = @scraper.scrape("9780321552686")
      expect(res[:code]).to eq "9780321552686"
      expect(res[:valid]).to eq false
      expect(res[:description]).to eq ""
      expect(res[:image_url]).to eq ""
      expect(res[:provider]).to eq "openfoodfacts.rb"
    end

    it '/valid item', :real_http=>false do
      res = @scraper.scrape("065633128507")
      expect(res[:code]).to eq "065633128507"
      expect(res[:valid]).to eq true
      expect(res[:description]).to eq "Mélange du randonneur - Val Nature - 5"
      expect(res[:image_url]).to eq "https://static.openfoodfacts.org/images/products/006/563/312/8507/front_fr.12.200.jpg"
      expect(res[:provider]).to eq "openfoodfacts.rb"
    end

    describe 'send/heartbeat', :real_http=>true do
        before {get '/send/heartbeat'}
      #  it {is_expected.to be_successful}
      it 'test success' do
        p self
      end
      # its(:body) { 
      #       expect(res[:code]).to eq"065633128507\"")
      # }
    end
  end
end 
