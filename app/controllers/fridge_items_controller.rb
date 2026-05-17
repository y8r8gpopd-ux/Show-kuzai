class FridgeItemsController < ApplicationController
  def index
    @fridge_item = FridgeItem.new

    if user_signed_in? && current_user.fridge_items.any?
      # ユーザーの冷蔵庫の使い切ってない食材
      fridge_items = current_user.fridge_items.available 
      # そこから食材ID抽出    
      ingredient_ids = fridge_items.pluck(:ingredient_id)   

      # ・レシピに中間テーブル接続 ・ユーザーの使い切ってない食材指定 ・重複は除外
      recipes = Recipe.joins(:recipe_ingredients)           
                      .where(recipe_ingredients: { ingredient_id: ingredient_ids })    
                      .distinct                             

      @fridge_ingredient_ids = fridge_items.pluck(:ingredient_id)  # ビューのレシピ表示用のインスタンス

      # トップページに渡すインスタンスをスコアで並べ替えてセット
      @recipes = recipes.all.sort_by do |recipe|
        score = 0
        recipe.recipe_ingredients.each do |ri|
          fridge_item = fridge_items.find do |item|
            item.ingredient_id == ri.ingredient_id
          end

          if fridge_item
            score += (Date.today - fridge_item.purchased_at).to_i
          end
        end

        -score
      end

    else
      @recipes = Recipe.all
    end

    if user_signed_in?
      @cooking_histories = current_user.cooking_history
                                       .includes(:recipe)
                                       .order(created_at: :desc)
                                       .limit(5)
    end

    render :index
  end

  def create
    @fridge_item = FridgeItem.new(fridge_item_params)
    @fridge_item.purchased_at = Date.today
    if @fridge_item.save
      redirect_to root_path
    else
      @recipes = Recipe.all
      render :index, status: :unprocessable_entity
    end

  end

  def manage
    @fridge_items = FridgeItem.where(user_id: current_user.id)
  end

  def update
    @fridge_item = FridgeItem.find(params[:id])
    if @fridge_item.update(fridge_item_params)
      redirect_to root_path
    else
      render :manage, status: :unprocessable_entity
    end
  end

  private
  def fridge_item_params
    params.require(:fridge_item).permit(:ingredient_id, :unit_id, :quantity, :status_id, :purchased_at).merge(user_id: current_user.id)
  end
end
