class Wine < ActiveRecord::Base
  
  belongs_to :appellation
  belongs_to :varietal
  belongs_to :vineyard
  
  has_many :labels
  has_many :wine_traits
  has_many :traits, through: :wine_traits
  
  validates :name, presence: true
  
  def self.create_from_winedotcom_hash(wine_hash: {})
    wine = Wine.find_or_create_by(winedotcom_id: wine_hash[:winedotcom_id]) do |w|
      w.name               = wine_hash[:name]
      w.url                = wine_hash[:url]
      # w.type               = wine_hash[:type]
      w.vintage            = wine_hash[:vintage]
      w.description        = wine_hash[:description]
      w.highest_score      = wine_hash[:highest_score]
      
      w.price_min          = wine_hash[:price_min]
      w.price_max          = wine_hash[:price_max]
      w.price_retail       = wine_hash[:price_retail]
      
      w.latitude           = wine_hash[:latitude]
      w.longitude          = wine_hash[:longitude]
      w.geo_url            = wine_hash[:geo_url]
      
      w.appellation        = wine_hash[:appellation]
      w.varietal           = wine_hash[:varietal]
      w.vineyard           = wine_hash[:vineyard]
    end
    
    # add trait if it hasn't been added to this wine previously
    wine_hash[:traits].each do |trait|
      (wine.traits << trait) unless wine.traits.exists?(winedotcom_id: trait.winedotcom_id)
    end
      
    wine
  end
  
  def as_json(options={})
    super(
      include: {
        varietal: { include: { wine_type: {} }},
        appellation: { include: { region: {} } },
        vineyard: {},
        traits: {},
        labels: {}
      }
    )
  end
  
  
end