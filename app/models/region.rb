class Region < ActiveRecord::Base
  
  has_many :appellations
  
  def self.create_from_winedotcom_hash(region: {})
    new_region = nil
    if region.present?
      new_region = Region.find_or_create_by(winedotcom_id: region[:Id]) do |r|
        r.name = region[:Name]
        r.url  = region[:Url]
      end
    end
    new_region
  end
  
end