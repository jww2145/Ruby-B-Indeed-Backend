class Listing < ActiveRecord::Base
    belongs_to :location
    belongs_to :company
    belongs_to :favorite

end