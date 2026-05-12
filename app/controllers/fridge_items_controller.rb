class FridgeItemsController < ApplicationController
  def index
    @recipes = Recipe.all
    @fridge_item = FridgeItem.new
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


  private
  def fridge_item_params
    params.require(:fridge_item).permit(:ingredient_id, :unit_id, :quantity).merge(user_id: current_user.id)
  end
end
