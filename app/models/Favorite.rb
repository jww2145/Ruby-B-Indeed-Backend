class Favorite < ActiveRecord::Base
    has_many :listings
    
end