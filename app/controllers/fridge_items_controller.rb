class FridgeItemsController < ApplicationController
  def index
    @recipes = Recipe.all
  end
end
