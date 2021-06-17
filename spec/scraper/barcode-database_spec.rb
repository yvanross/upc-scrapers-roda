require_relative '../../scraper/barcode-database'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'

RSpec.describe 'barcode-database' do
  before(:each) do
    @scraper = BarcodeDatabase.new
  end
 
  it '/valid item' do
    res = @scraper.scrape("9780321552686")
    expect(res[:code]).to eq "9780321552686"
    expect(res[:valid]).to eq true
    expect(res[:description]).to eq "Documenting Software Architectures: Views And Beyond (2nd Edition)"
    expect(res[:image_url]).to eq "https://images.barcodesdatabase.org/file/barcodesdatabase/978/032/155/9780321552686.jpg"
    expect(res[:provider]).to eq "barcode-database.rb"
  end 

  it '/invalid item' do
    res = @scraper.scrape("065633128507333336666")
    expect(res[:code]).to eq "065633128507333336666"
    expect(res[:valid]).to eq false
    expect(res[:description]).to eq ""
    expect(res[:image_url]).to eq ""
    expect(res[:provider]).to eq "barcode-database.rb"
  end
end 