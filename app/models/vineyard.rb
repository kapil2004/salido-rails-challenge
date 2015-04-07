class Vineyard < ActiveRecord::Base
  
  has_many :wines
  
  def self.create_from_winedotcom_hash(vineyard: {})
    new_vineyard = nil
    if vineyard.present?
      new_vineyard = Vineyard.find_or_create_by(winedotcom_id: vineyard[:Id]) do |v|
        v.name      = vineyard[:Name]
        v.url       = vineyard[:Url]
        v.image_url = vineyard[:ImageUrl]
        v.latitude  = vineyard[:GeoLocation][:Latitude]
        v.longitude = vineyard[:GeoLocation][:Longitude]
        v.geo_url   = vineyard[:GeoLocation][:Url]
      end
    end
    new_vineyard
  end
  
  
end