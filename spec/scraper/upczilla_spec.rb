require_relative '../../scraper/upczilla.rb'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'
 
RSpec.describe 'Upczilla' do
  before(:each) do
    @scraper = Upczilla.new
  end

  it '/valid item' do
    res = @scraper.scrape("756619009407")
    expect(res[:code]).to eq "756619009407" 
    expect(res[:valid]).to eq true
    expect(res[:description]).to eq "Elenco - XMH-218 Solid Hook-Up Wire Kit 6 Colors in a dispenser box # WK-106"
    expect(res[:image_url]).to eq "https://www.upczilla.com/wp-content/plugins/storeminator/cache/images/756/619/009/756619009407.webp"
    expect(res[:provider]).to eq "upczilla.rb"
  end      
 
  it '/invalid item' do
    res = @scraper.scrape("065633128507333336666")
    expect(res[:code]).to eq "065633128507333336666"
    expect(res[:valid]).to eq false
    expect(res[:description]).to eq ""
    expect(res[:image_url]).to eq ""
    expect(res[:provider]).to eq "upczilla.rb"
  end 
  
end   