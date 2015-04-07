class Appellation < ActiveRecord::Base
  
  has_many :wines
  belongs_to :region
  
  def self.create_from_winedotcom_hash(appellation: {}, region: nil)  
    new_appellation = nil
    if appellation.present?
      new_appellation = Appellation.find_or_create_by(winedotcom_id: appellation[:Id]) do |a|
        a.name   = appellation[:Name]
        a.url    = appellation[:Url]
        a.region = region
      end
    end
    new_appellation
  end
  
  def display_name
    "#{name} (Region: #{region.name})"
  end
  
end