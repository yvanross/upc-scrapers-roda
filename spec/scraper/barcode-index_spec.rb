require_relative '../../scraper/barcode-index'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'

RSpec.describe 'barcode-index' do
  before(:each) do
    @scraper = BarcodeIndex.new
  end

  it '/valid item' do
    res = @scraper.scrape("064042006529")
    expect(res[:code]).to eq "064042006529"
    expect(res[:valid]).to eq true
    expect(res[:description]).to eq "Leclerc Celebration Dark Chocolate Butter Cookies Made with Real 45 Cocoa Dark Chocolate 240g"
    expect(res[:image_url]).to eq "https://barcodeindex.s3.amazonaws.com/images/064042006529.jpg"
    expect(res[:provider]).to eq "barcode-index.rb"
  end 

  it '/invalid item' do
    res = @scraper.scrape("065633128507333336666")
    expect(res[:code]).to eq "065633128507333336666"
    expect(res[:valid]).to eq false
    expect(res[:description]).to eq ""
    expect(res[:image_url]).to eq ""
    expect(res[:provider]).to eq "barcode-index.rb"
  end
end 