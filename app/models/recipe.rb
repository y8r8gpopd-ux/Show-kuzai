class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_one_attached :image
  accepts_nested_attributes_for :recipe_ingredients,
                                allow_destroy: true,
                                reject_if: proc { |attrs| attrs['ingredient_id'].blank? }

  validates :name, :image, :how_to_cook, presence: true
  validate :must_have_ingredient

  private
   def must_have_ingredient
    if recipe_ingredients.empty?
      errors.add(:base, "材料を1つ以上追加してください")
    end
  end
  
end
