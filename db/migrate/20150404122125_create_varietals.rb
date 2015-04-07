class CreateVarietals < ActiveRecord::Migration
  def change
    create_table :varietals do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      t.references :wine_type, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
