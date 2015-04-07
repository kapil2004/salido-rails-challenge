class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      
      t.timestamps
    end
  end
end
