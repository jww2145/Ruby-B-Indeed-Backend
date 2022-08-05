class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
      create_table :favorites do |t|
        t.boolean :liked
        t.integer :listing_id 
    end
  end
end
