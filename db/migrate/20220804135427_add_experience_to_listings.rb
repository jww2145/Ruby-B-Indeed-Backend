class AddExperienceToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :experience, :string
  end
end
