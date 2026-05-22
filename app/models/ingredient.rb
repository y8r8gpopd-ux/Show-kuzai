class Ingredient < ApplicationRecord
  has_many :fridge_items
  has_many :shopping_list_items

  validates :name, presence: true, uniqueness: true

  # ransack用の記述
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
