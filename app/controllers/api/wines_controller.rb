module API
  class WinesController < ApplicationController
  
    # GET
    # default limit is 10
    # default ordering is by name attribute
    def index
      limit = params[:limit] || 10
      offset = params[:offset] || 0
      wines = Wine.order(:name).offset(offset).limit(limit).all

      if params[:filter]
        wines = wines.where("name LIKE '%#{params[:filter]}%'")
      end  
      render json: wines, status: 200
    end
    
    # PATCH
    def update
      wine = Wine.find params[:id]
      if wine.update(wine_params)
        render json: wine, status: 200
      else
        render json: wine.errors, status: 422
      end
    end
    
    
    private
    
      # the following parameters are allowed to be updated
      def wine_params
        params
        .require(:wine)
        .permit(
          :name, 
          :description, 
          :url, 
          :vintage, 
          :price_min, 
          :price_max, 
          :price_retail, 
          :highest_score, 
          :appellation_id, 
          :varietal_id, 
          :vineyard_id,
          :trait_ids => []
        )
      end
  
  end
end