class Location < ActiveRecord::Base
    has_many :listings
    has_many :companies, through: :listings
end