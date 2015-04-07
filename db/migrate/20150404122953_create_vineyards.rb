class CreateVineyards < ActiveRecord::Migration
  def change
    create_table :vineyards do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      t.string :image_url
      t.float :latitude
      t.float :longitude
      t.string :geo_url
      
      t.timestamps
    end
  end
end
