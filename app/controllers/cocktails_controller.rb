class CocktailsController < ApplicationController
  before_action :set_cocktail, only: [:show, :edit, :update, :destroy]

  def index
    @cocktails = Cocktail.all
  end

  def show; end

  def new
    @ingredients = Ingredient.all
    @cocktail = Cocktail.new
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)

    if @cocktail.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      @ingredients = Ingredient.all
      @dose = Dose.new
      render :new
    end
  end

  def edit
    @dose = Dose.new
  end

  def update
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail)

    else
      @dose = Dose.new
      render :edit
    end
  end

  def destroy
    @cocktail.destroy

    redirect_to cocktails_path
  end

  private

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :image_url, :description)
  end
end
