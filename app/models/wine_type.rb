class WineType < ActiveRecord::Base
  
  has_many :varietals
  
  def self.create_from_winedotcom_hash(wine_type: {})
    new_wine_type = nil
    
    if wine_type.present?
      new_wine_type = WineType.find_or_create_by(winedotcom_id: wine_type[:Id]) do |wt|
        wt.name = wine_type[:Name]
        wt.url  = wine_type[:Url]
      end
    end
    
    new_wine_type
  end
  
end