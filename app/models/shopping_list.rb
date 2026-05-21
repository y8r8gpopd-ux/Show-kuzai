class ShoppingList < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :ingredients, through: :shopping_list_items
  has_many :shopping_list_items, dependent: :destroy

  validates :recipe_id, uniqueness: { scope: :user_id }
end
