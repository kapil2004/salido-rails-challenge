class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :winedotcom_id, index: true
      t.string :name
      t.string :url
      t.references :wine, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
