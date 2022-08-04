require 'nokogiri'
require 'httparty'
require 'byebug'
require_relative '../app/models/Company'

puts "🌱 Seeding..."

def scraper(url)
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
end

def findLocation(parsed_text)
    if parsed_text.include?('Remote')
        return 'Remote'
    elsif parsed_text.include?('USA')
        return 'USA'
    else
        return parsed_text.match(/([A-Z]{2})/)
    end
end

page = 0 

while page < 50 
    jobCards = scraper("https://www.indeed.com/jobs?q=Software&l=United%20States&start=#{page}").css('div.job_seen_beacon')
    jobCards.each do |job|
    
        location = findLocation(job.css('div.companyLocation').text)
    
        Company.create(
            name: job.css('span.companyName').text
        )
    
        City.create(
            name: location   
            #job.css('div.companyLocation').text.match(/([A-Z]{2})/)
        )
    end

    page = page + 10
end



puts "✅ Done seeding!"
