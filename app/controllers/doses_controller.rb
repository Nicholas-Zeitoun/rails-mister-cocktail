class DosesController < ApplicationController
  before_action :set_cocktail, only: [:new, :show, :create]

  def new
    @ingredients = Ingredient.all
    @dose = Dose.new
  end

  def came_from_update_page?
    params[:update_cocktail]
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.ingredient_id = params[:dose][:ingredient_id]
    @dose.cocktail = @cocktail

    if came_from_update_page? # when updating ingredient
      @dose.save
      redirect_to edit_cocktail_path(@cocktail)
    else # will redirect to cocktail dose create page
      if @dose.save
        redirect_to new_cocktail_dose_path(@cocktail)
      else
        render :new
      end
    end
  end

  def destroy
    # @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.find(params[:id])
    @dose.delete
    redirect_to root_path
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient)
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
