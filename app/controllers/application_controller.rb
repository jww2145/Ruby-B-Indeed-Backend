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

  patch "/favorites/:listing_id" do
    begin
      found_favorite = Favorite.find(params[:listing_id])
      found_favorite.update(params)
      if !found_favorite.liked
        found_favorite.liked = !found_favorite.liked
        found_favorite.save
      end
      found_favorite.to_json
    rescue
      { error: "Couldn't find that darn listing" }.to_json
    end
  end

  get "/list-favorites" do
    Favorite.all.filter { |favorite| favorite.liked}.to_json
  end

end


