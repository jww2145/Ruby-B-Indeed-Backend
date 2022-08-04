class AddJobtypeToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :jobType, :string
  end
end
