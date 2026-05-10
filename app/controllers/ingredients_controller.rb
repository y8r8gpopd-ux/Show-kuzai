class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end


  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to new_ingredient_path
    else
      if @ingredient.errors[:name].present?
        flash.now[:alert] = "その食材はすでに登録されています"
      else
        flash.now[:alert] = "登録に失敗しました"
      end
      
      render :new, status: :unprocessable_entity
    end

  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
end
