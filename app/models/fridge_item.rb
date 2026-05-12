class FridgeItem < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :ingredient
  belongs_to :unit
  belongs_to :status
  
  validates :ingredient_id, presence: true
end
