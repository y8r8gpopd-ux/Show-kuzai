class FridgeItem < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :ingredient
  belongs_to :unit
  belongs_to :status
  
  validates :ingredient_id, presence: true

  scope :available, -> { where.not(status_id: 2) }
end
