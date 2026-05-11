class FridgeItemsController < ApplicationController
  layout false
  def index
    @recipes = Recipe.all
  end
end
