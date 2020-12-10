class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.text :options
      t.string :source
      t.string :image_url
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
