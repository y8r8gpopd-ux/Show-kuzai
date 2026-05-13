class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to root_path
    else
      flash.now[:alert] = "リロードしてやり直してください"
      render :new, status: :unprocessable_entity
    end
  end

  def cook
    @recipe = Recipe.find(params[:id])

    ingredient_ids = @recipe.recipe_ingredients.pluck(:ingredient_id)

    current_user.fridge_items
                .available
                .where(ingredient_id: ingredient_ids)
                .update_all(status_id: 2)

    redirect_to root_path
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