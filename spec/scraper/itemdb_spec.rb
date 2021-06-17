require_relative '../../scraper/itemdb'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'

RSpec.describe 'itemdb' do
  before(:each) do
    @scraper = ItemDb.new
  end

  it '/valid item' do
    res = @scraper.scrape("9780321552686")
    expect(res[:code]).to eq "9780321552686"
    expect(res[:valid]).to eq true
    expect(res[:description]).to eq "Documenting Software Architectures"
    expect(res[:image_url]).to eq "https://target.scene7.com/is/image/Target/GUEST_9e0447a3-5002-4370-95fc-f9cc6703dcf7?wid=1000&hei=1000"
    expect(res[:provider]).to eq "itemdb.rb"
  end

  it '/invalid item' do
    res = @scraper.scrape("7566190094071213")
    expect(res[:code]).to eq "7566190094071213"
    expect(res[:valid]).to eq false
    expect(res[:description]).to eq ""
    expect(res[:image_url]).to eq "" 
    expect(res[:provider]).to eq "itemdb.rb"
  end

end 