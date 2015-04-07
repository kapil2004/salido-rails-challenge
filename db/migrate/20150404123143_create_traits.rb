class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      t.string :image_url
      
      t.timestamps
    end
  end
end
