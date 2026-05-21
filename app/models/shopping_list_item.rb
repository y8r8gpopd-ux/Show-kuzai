class ShoppingListItem < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :shopping_list
  belongs_to :ingredient
  belongs_to :unit
end
