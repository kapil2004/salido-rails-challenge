class WinesController < ApplicationController
  
  before_action :load_lists, only: [:new, :edit]
  
  def index
    params[:page] ||= 1
    @wines = Wine.includes(:appellation, :varietal, :vineyard).page(params[:page]).order(:name)
  end
  
  def show
    @wine = Wine.includes([{appellation: :region}, {varietal: :wine_type}, :vineyard, :wine_traits, :traits]).find(params[:id])
  end
  
  def edit
    @wine = Wine.includes([{appellation: :region}, {varietal: :wine_type}, :vineyard, :wine_traits, :traits]).find(params[:id])
  end
  
  def update
    @wine = Wine.find(params[:id])
    if @wine.update(wine_params)
      flash[:notice] = "Successfully updated wine."
      redirect_to wine_url(@wine)
    else
      render action: 'edit'
    end
  end
  
  def new
    @wine = Wine.new
  end
  
  def create
    @wine = Wine.new(wine_params)
    if @wine.save
      flash[:notice] = "Successfully created wine."
      redirect_to wine_url(@wine)
    else
      render action: 'new'
    end
  end
  
  
  private
  
    def load_lists
      @appellations       = Appellation.includes(:region).order(:name).all
      @varietals          = Varietal.includes(:wine_type).order(:name).all
      @vineyards          = Vineyard.order(:name).all
      @traits             = Trait.order(:name).all
    end
  
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

