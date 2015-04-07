class CreateWineTraits < ActiveRecord::Migration
  def change
    create_table :wine_traits do |t|
      t.references :wine, index: true, foreign_key: true
      t.references :trait, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end
