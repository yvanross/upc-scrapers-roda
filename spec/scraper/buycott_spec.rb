require_relative '../../scraper/buycott'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'

RSpec.describe 'buycott', roda: :app do
  before(:each) do
    @scraper = Buycott.new
  end

  it '/valid item' do
    res = @scraper.scrape("756619009407")
    expect(res[:code]).to eq "756619009407"
    expect(res[:valid]).to eq true
    expect(res[:description]).to eq "Elenco WK-106 Hook Up Wire Kit. 6- 25' Rolls (red, Black, Green, Yellow, White"
    expect(res[:image_url]).to eq "http://images10.newegg.com/ProductImageCompressAll200/A3C6_1_201611041343676280.jpg"
    expect(res[:provider]).to eq "buycott.rb"
  end 

  it '/invalid item' do
    res = @scraper.scrape("065633128507333336666")
    expect(res[:code]).to eq "065633128507333336666"
    expect(res[:valid]).to eq false
    expect(res[:description]).to eq ""
    expect(res[:image_url]).to eq ""
    expect(res[:provider]).to eq "buycott.rb"
  end
end 