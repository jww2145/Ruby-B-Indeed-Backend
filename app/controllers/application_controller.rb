class ApplicationController < Sinatra::Base
  require 'nokogiri'
  require 'httparty'
  require 'byebug'
  
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end
  
  def scraper(url)
      unparsed_page = HTTParty.get(url)
      parsed_page = Nokogiri::HTML(unparsed_page)
      byebug
  end
end


