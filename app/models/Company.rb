class Company < ActiveRecord::Base
    has_many :listings
    has_many :locations, through: :listings
    
end