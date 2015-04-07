class Label < ActiveRecord::Base
  
  belongs_to :wine
  
  def self.create_from_winedotcom_hash(labels: [], wine: nil)
    new_labels = []
    labels.each do |label|
      new_labels << Label.find_or_create_by(winedotcom_id: label[:Id]) do |l|
        l.name = label[:Name]
        l.url = label[:Url]
        l.wine = wine
      end
    end
    new_labels
  end
  
end