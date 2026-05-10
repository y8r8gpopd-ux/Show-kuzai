class RecipeIngredient < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :unit_id
  belongs_to :recipe
  belongs_to :ingredient
end