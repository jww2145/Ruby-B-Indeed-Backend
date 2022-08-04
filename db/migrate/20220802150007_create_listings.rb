class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :description 
      t.integer :company_id
      t.integer :location_id
    end
  end
end
