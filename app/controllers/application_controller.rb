class ApplicationController < Sinatra::Base
  
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  #get for locations 

  get "/locations" do 
    Location.all.to_json
  end

  get "/companies" do 
    Company.all.to_json
  end

  get "/listings" do
    Listing.all.to_json(include: [:company, :location])
  end





end


