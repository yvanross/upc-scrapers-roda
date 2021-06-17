require_relative '../../scraper/google-shopping'
require_relative '../spec_helper'
require 'httparty'
require 'nokogiri'

RSpec.describe 'google-shopping' do

  before(:each) do
    @scraper = GoogleShopping.new
  end

  it '/valid item' do
    res = @scraper.scrape("065633128507")
    expect(res[:code]).to eq "065633128507"
    expect(res[:valid]).to eq true
    expect(res[:description]).to eq "ⓘNature Valley Trail Mix Chewy Granola Bars - Fruit & Nut - 175g"
    expect(res[:image_url]).to eq "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTjy9JpBBTo9ufpcPBU1-4zVKIpmSLW4Ai8PTrVK5LybjRugJ_cziDiWfQ&usqp=CAE"
    expect(res[:provider]).to eq "google-shopping.rb"
  end

  it '/invalid item' do
    res = @scraper.scrape("7566190094071213")
    expect(res[:code]).to eq "7566190094071213"
    expect(res[:valid]).to eq false
    expect(res[:description]).to eq ""
    expect(res[:image_url]).to eq ""
    expect(res[:provider]).to eq "google-shopping.rb"
  end
end 