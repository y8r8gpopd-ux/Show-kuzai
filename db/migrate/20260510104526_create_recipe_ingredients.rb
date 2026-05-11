class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe, null: false
      t.references :ingredient, null: false
      t.integer :quantity, null: false
      t.integer :unit_id, null: false
      t.timestamps
    end
  end
end
