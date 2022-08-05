class Listing < ActiveRecord::Base
    belongs_to :location
    belongs_to :company
    belongs_to :favorite
    has_many :comments

end