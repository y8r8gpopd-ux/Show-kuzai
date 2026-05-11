class RecipeIngredient < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :unit
  belongs_to :recipe
  belongs_to :ingredient

  validates :ingredient_id, :quantity, :unit_id, presence: true
end