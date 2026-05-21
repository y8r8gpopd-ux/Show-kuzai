class Ingredient < ApplicationRecord
  has_many :fridge_items
  has_many :shopping_list_items

  validates :name, presence: true, uniqueness: true
end
