require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    url = "https://www.indeed.com/jobs?q=software&l=United%20States"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    byebug
end

scraper