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
    states = {
        "Alabama" => "AL",
        "Alaska"=>  "AK",
        "Arizona"=> "AZ",
        "Arkansas"=>"AR",
        "California"=>"CA",
        "Colorado"=>"CO",
        "Connecticut"=> "CT",
        "Delaware"=>"DE",
        "District of Columbia" => "DC",
        "Florida"=> "FL",
        "Georgia"=> "GA",
        "Hawaii"=>  "HI",
        "Idaho"=>   "ID",
        "Illinois"=>"IL",
        "Indiana"=> "IN",
        "Iowa"=>"IA",
        "Kansas"=>"KS",
        "Kentucky"=>"KY",
        "Louisiana"=>"LA",
        "Maine"=>"ME",
        "Maryland"=>"MD",
        "Massachusetts"=>"MA",
        "Michigan"=>"MI",
        "Minnesota"=>"MN",
        "Mississippi"=> "MS",
        "Missouri"=>"MO",
        "Montana"=> "MT",
        "Nebraska"=>"NE",
        "Nevada"=>  "NV",
        "New Hampshire"=>"NH",
        "New Jersey"=>  "NJ",
        "New Mexico"=>"NM",
        "New York"=>"NY",
        "North Carolina"=>"NC",
        "North Dakota"=>"ND",
        "Ohio"=>"OH",
        "Oklahoma"=>"OK",
        "Oregon"=>  "OR",
        "Pennsylvania"=>"PA",
        "Puerto Rico"=>"PR",
        "Rhode Island"=>"RI",
        "South Carolina"=>"SC",
        "South Dakota"=>"SD",
        "Tennessee"=>"TN",
        "Texas" =>"TX",
        "United States" => "USA",
        "United States of America" => "USA",
        "Utah"=>"UT",
        "Vermont"=> "VT",
        "Virginia"=>"VA",
        "Washington"=>"WA",
        "West Virginia"=>"WV",
        "Wisconsin" =>"WI",
        "Wyoming"=> "WY"
    }

    if parsed_text.include?('Remote')
        return 'Remote'
    elsif parsed_text.include?('USA')
        return 'USA'
    elsif states.has_key?(parsed_text)
        return states[parsed_text]
    else
        return parsed_text.match(/([A-Z]{2})/)[0]
    end
end

def findJobType(parsed_text)

    if parsed_text.include?("Full-time")
        return "Full-time"
    elsif parsed_text.include?("Part-time")
        return "Part-time"
    elsif parsed_text.include?("Contract")
        return "Contract"
    elsif parsed_text.include?("Internship")
        return "Internship"
    else
        return "Full-time"
    end

end


def findExperienceLevel(parsed_text)
    title = parsed_text.split(' ', -1)
    entry = ["New Grad", "Entry Level", "New", "New Graduate", "Junior", "Early-Career", "Jr.", "Entry-Level", "Training"]
    mid = ["Level 2", "Manager", "II", "III", "Mid-Level", "Mid", "Intermediate"]
    senior = ["Senior", "Sr.", "Manager", "Director", "Mgr", "IV", "Sr", "Chief", "Head"]


    if entry.length > (entry - title).length
        return 'Entry'
    elsif mid.length > (mid - title).length 
        return 'Mid'
    elsif senior.length > (senior - title).length
        return 'Senior'
    else 
        return 'Mid'
    end 
end

def getURL(parsed_text)
    "https://www.indeed.com#{parsed_text}"
end


page = 0 

while page < 20
    jobCards = scraper("https://www.indeed.com/jobs?q=Software&l=United%20States&start=#{page}").css('div.job_seen_beacon')
    jobCards.each do |job|
    
        location = findLocation(job.css('div.companyLocation').text)
        experience = findExperienceLevel(job.css('h2.jobTitle').css('span').text)
        company = job.css('span.companyName').text
        description = job.css('table.jobCardShelfContainer').css('ul').css('li').text
        jobType = findJobType(job.css('div.attribute_snippet').text)

        jobURL = getURL(job.css('h2').css('a')[0].attributes["href"].value)


        newCompany = Company.find_or_create_by(name: company)
        newLocation = Location.find_or_create_by(name: location || "Unknown")
        
        newListing = Listing.create(
            name: job.css('h2.jobTitle').css('span').text,
            description: description,
            company_id: newCompany.id,
            location_id: newLocation.id,
            experience: experience,
            jobType: jobType,
            url: jobURL
        )

        Favorite.create(
            listing_id: newListing.id,
            liked: false
        )
    end
    page = page + 10
end



puts "✅ Done seeding!"
