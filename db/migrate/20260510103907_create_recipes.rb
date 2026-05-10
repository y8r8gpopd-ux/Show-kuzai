class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :genre_id, null: false
      t.text :how_to_cook, null: false
      t.timestamps
    end
  end
end
