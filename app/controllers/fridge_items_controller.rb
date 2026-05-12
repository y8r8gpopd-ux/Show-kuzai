class FridgeItemsController < ApplicationController
  def index
    @recipes = Recipe.all
    @fridge_item = FridgeItem.new
  end

  def create
    @fridge_item = FridgeItem.new(fridge_item_params)
    @fridge_item.purchased_at = Date.today
    if fridge_item.save
      redirect_to ingredients_path
    else
      render :index
    end

  end


  private
  def fridge_item_params
    params.require(:fridge_item).permit(:unit_id, :quantity).marge(user_id: current_user.id, ingredient_id: params[:ingredient_id])
  end
end
