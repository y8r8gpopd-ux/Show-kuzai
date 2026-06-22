class FridgeItemsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :manage, :update] 


  def index
    @fridge_item = FridgeItem.new
    @recipes = Recipe.all
    # nilガード↓先に空配列用意して、下のif文で再代入
    @fridge_ingredient_ids ||= []

    if user_signed_in? && current_user.fridge_items.available.any?
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
            score += (Date.today - fridge_item.purchased_at).to_i + 1
          end
        end

        -score
      end

    
    end

    if user_signed_in? 

      # お買い物リスト用のインスタンス生成
      if current_user.shopping_lists.any?
        @shopping_lists = current_user.shopping_lists.includes(:recipe,
                                        shopping_list_items: :ingredient)
      end

      # 調理履歴のインスタンス生成 
      @cooking_histories = current_user.cooking_histories
                                       .includes(:recipe)
                                       .order(created_at: :desc)
                                       .limit(5)
    end

    render :index
  end

  def create
    ingredient_ids = params[:fridge_item][:ingredient_ids] || []

    if ingredient_ids.empty?
      redirect_to root_path, alert: "食材を選択してください"
      return
    end

    ingredient_ids.each do |ingredient_id|
      FridgeItem.create(fridge_item_params.merge(ingredient_id: ingredient_id, purchased_at: Date.today))
    end

      redirect_to root_path
  end

  def manage
    @fridge_items = FridgeItem.where(user_id: current_user.id).order(purchased_at: :DESC)
  end

  def update
    @fridge_item = FridgeItem.find(params[:id])
    if @fridge_item.update(fridge_item_params)
      redirect_to manage_fridge_items_path
    else
      render :manage, status: :unprocessable_entity
    end
  end

  private
  
  def fridge_item_params
    params.require(:fridge_item).permit(:quantity, :unit_id, :status_id, :purchased_at).merge(user_id: current_user.id)
  end

end
