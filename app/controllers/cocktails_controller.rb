class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show]

  def index
    @cocktails = Cocktail.all
  end

  def show
  end

  def new
    @ingredients = Ingredient.all
    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)

    if @cocktail.save!
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :image_url)
  end
end
