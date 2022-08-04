class AddUrlToListings < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :url, :string
  end
end
