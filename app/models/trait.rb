class Trait < ActiveRecord::Base
  
  has_many :wine_traits
  has_many :wines, through: :wine_traits
  
  def self.create_from_winedotcom_hash(traits: [])
    new_traits = []
    if traits.present?
      traits.each do |trait|
        new_traits << Trait.find_or_create_by(winedotcom_id: trait[:Id]) do |t|
          t.name      = trait[:Name]
          t.url       = trait[:Url]
          t.image_url = trait[:ImageUrl]
        end
      end
    end
    new_traits
  end
  
end