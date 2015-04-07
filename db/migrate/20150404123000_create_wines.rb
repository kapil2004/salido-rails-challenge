class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      t.string :vintage
      t.decimal :price_max, precision: 10, scale: 2
      t.decimal :price_min, precision: 10, scale: 2
      t.decimal :price_retail, precision: 10, scale: 2
      t.text :description
      t.decimal :highest_score
      t.float :latitude
      t.float :longitude
      t.string :geo_url
      t.references :appellation, index: true, foreign_key: true
      t.references :varietal, index: true, foreign_key: true
      t.references :vineyard, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
