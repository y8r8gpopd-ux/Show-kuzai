class Ingredient < ApplicationRecord
  has_many :fridge_items

  validates :name, presence: true, uniqueness: true
end
