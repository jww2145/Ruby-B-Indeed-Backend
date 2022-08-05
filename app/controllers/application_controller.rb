require 'sinatra'

class ApplicationController < Sinatra::Base
  
  set :default_content_type, 'application/json'
  

  #get for locations 
  get "/favorites" do
    Favorite.all.to_json
  end


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
      found_favorite.liked = !found_favorite.liked
      found_favorite.save
      found_favorite.to_json
    rescue
      { error: "Couldn't find that darn listing" }.to_json
    end
  end

  get "/list-favorites" do
    Favorite.all.filter { |favorite| favorite.liked}.to_json
  end

end


