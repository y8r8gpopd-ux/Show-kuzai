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

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      redirect_to root_path
    else
      if @ingredient.errors[:name].present?
        flash.now[:alert] = "その食材はすでに登録されています"
      else
        flash.now[:alert] = "登録に失敗しました"
      end

      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    redirect_to ingredients_path
  end



  def search
    @ingredients = Ingredient.where("name LIKE ?", "%#{params[:keyword]}%")
  end

  private
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
end
