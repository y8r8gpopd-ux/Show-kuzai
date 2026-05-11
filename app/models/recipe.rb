class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_one_attached :image
  accepts_nested_attributes_for :recipe_ingredients

  validates :name, :image, :how_to_cook, presence: true
end
