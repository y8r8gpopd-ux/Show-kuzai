class Recipe < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_one_attached :image
  belongs_to :genre
  has_many :cooking_histories
  has_many :shopping_lists
  
  accepts_nested_attributes_for :recipe_ingredients,
                                allow_destroy: true,
                                reject_if: proc { |attrs| 
                                  attrs['ingredient_id'].blank? &&
                                  attrs['quantity'].blank? &&
                                  attrs['unit_id'].blank?}

  validates :name, :image, :how_to_cook, presence: true
  validate :must_have_ingredient

  # ransack用の記述
  def self.ransackable_attributes(auth_object = nil)
    ["name", "genre_id", "how_to_cook", "created_at", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["ingredients", "recipe_ingredients"]
  end
  
  private
   def must_have_ingredient
    if recipe_ingredients.empty?
      errors.add(:base, "材料を1つ以上追加してください")
    end
  end

end
