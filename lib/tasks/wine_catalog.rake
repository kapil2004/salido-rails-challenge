namespace :salido do
  
  desc 'task to download wine.com catalog and load it into our db'
  task :get_wine_catalog => :environment do
    
    API_KEY = '0fbbbe4e73fc5de925f91b2bb43d87ef'
    
    BASE_URL = "http://services.wine.com/api/beta2/service.svc"
    FORMAT = "json"
    RESOURCE = "catalog"
    PER_REQUEST = 100
    
    
    # flag for while loop
    more_wines = true
    
    offset = 0
    
    while more_wines do
      # send get request
      url = URI.parse "#{BASE_URL}/#{FORMAT}/#{RESOURCE}?apikey=#{API_KEY}&offset=#{offset}&size=#{PER_REQUEST}"
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end
      wines_json = JSON.parse(res.body, symbolize_names: true)
      
      wines_array = wines_json[:Products][:List]
      wines_count = wines_array.size
      
      # create wines in db
      wines_array.each do |wine|
        
        h_appellation        = wine[:Appellation] || {}
        h_region             = wine[:Appellation].present? ? wine[:Appellation][:Region] : {}
        h_labels             = wine[:Labels] || []
        h_varietal           = wine[:Varietal] || {}
        h_wine_type          = wine[:Varietal].present? ? wine[:Varietal][:WineType] : {}
        h_vineyard           = wine[:Vineyard] || {}
        h_traits             = wine[:ProductAttributes] || []
        
        region             = Region.create_from_winedotcom_hash(region: h_region)
        appellation        = Appellation.create_from_winedotcom_hash(appellation: h_appellation, region: region)
        wine_type          = WineType.create_from_winedotcom_hash(wine_type: h_wine_type)
        varietal           = Varietal.create_from_winedotcom_hash(varietal: h_varietal, wine_type: wine_type)
        vineyard           = Vineyard.create_from_winedotcom_hash(vineyard: h_vineyard)
        traits             = Trait.create_from_winedotcom_hash(traits: h_traits)
                
        wine_hash = {
          winedotcom_id:      wine[:Id],
          name:               wine[:Name],
          url:                wine[:Url],
          vintage:            wine[:Vintage],
          price_max:          wine[:PriceMax],
          price_min:          wine[:PriceMin],
          price_retail:       wine[:PriceRetail],
          description:        wine[:Description],
          latitude:           wine[:GeoLocation][:Latitude],
          longitude:          wine[:GeoLocation][:Longitude],
          geo_url:            wine[:GeoLocation][:Url],
          highest_score:      wine[:Ratings][:HighestScore],
          appellation:        appellation,
          varietal:           varietal,
          vineyard:           vineyard,
          traits:             traits
        }
        
        wine = Wine.create_from_winedotcom_hash(wine_hash: wine_hash)
        labels = Label.create_from_winedotcom_hash(labels: h_labels, wine: wine)
        
        print '.'
      end
      
      # if count < PER_REQUEST, more_wines = false
      if wines_count < PER_REQUEST
        more_wines = false
      end
      
      offset = offset + PER_REQUEST
      puts offset
    end
    
  end
  
end
