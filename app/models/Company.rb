class Company < ActiveRecord::Base
    has_many :listings
    has_many :cities, through: :listings
    
end