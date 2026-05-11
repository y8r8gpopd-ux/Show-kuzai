class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def recipe_params
      params.require(:recipe).permit(
      :name,
      :genre_id,
      :image,
      :how_to_cook,
      recipe_ingredients_attributes: [
        :ingredient_id,
        :quantity,
        :unit_id
        ]
      )
    end

end