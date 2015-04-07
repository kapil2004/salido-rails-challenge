class Varietal < ActiveRecord::Base
  
  has_many :wines
  belongs_to :wine_type
  
  def self.create_from_winedotcom_hash(varietal: {}, wine_type: nil)
    new_varietal = nil
    if varietal.present?
      new_varietal = Varietal.find_or_create_by(winedotcom_id: varietal[:Id]) do |v|
        v.name      = varietal[:Name]
        v.url       = varietal[:Url]
        v.wine_type = wine_type
      end
    end
    new_varietal
  end
  
  def display_name
    "#{name} (Wine Type: #{wine_type.name})"
  end
  
end