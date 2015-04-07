class CreateAppellations < ActiveRecord::Migration
  def change
    create_table :appellations do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      t.references :region, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
