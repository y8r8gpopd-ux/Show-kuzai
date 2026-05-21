class RecipesController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update]

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

    # レシピの載っている食材を冷蔵庫の古いものから１つずつ取り出す
    @recipe.recipe_ingredients.each do |ri|
      fridge_item = current_user.fridge_items
                                .available
                                .where(ingredient_id: ri.ingredient_id)
                                .order(:purchased_at)
                                .first

      # 重複なしで古いもののみstatus更新
      fridge_item&.update(status_id: 2)
    end

    # ユーザーの調理履歴作成
    current_user.cooking_histories.create(recipe_id: @recipe.id)
                
    redirect_to root_path
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to root_path
    else
      flash.now[:alert] = "やり直してください"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to root_path
  end

  def add_to_shopping_list
    recipe = Recipe.find(params[:id])

    # shopping_listをユーザー、レシピのidで保存
    shopping_list = ShoppingList.create(
      user_id: current_user.id,
      recipe_id: recipe.id
    )

    # ユーザーの冷蔵庫の中身取り出し
    fridge_ingredient_ids = current_user.fridge_items
                                        .available
                                        .pluck(:ingredient_id)

    # 中間テーブルshopping_list_itemに冷蔵庫の食材と照らし合わせてないものだけ保存
    recipe.recipe_ingredients.each do |ri|

      unless fridge_ingredient_ids.include?(ri.ingredient_id)

      ShoppingListItem.create(
        shopping_list_id: shopping_list.id,
        ingredient_id: ri.ingredient_id,
        quantity: ri.quantity,
        unit_id: ri.unit_id
      )

    end
  end

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

    def authenticate_admin!
      redirect_to root_path unless current_user.admin?
    end
end