class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
      create_table :favorites do |t|
        t.boolean :false
        t.integer :listing_id 
    end
  end
end
