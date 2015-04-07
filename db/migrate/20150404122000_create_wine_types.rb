class CreateWineTypes < ActiveRecord::Migration
  def change
    create_table :wine_types do |t|
      t.integer :winedotcom_id, index: true
      t.string :name
      t.string :url
      
      t.timestamps
    end
  end
end
