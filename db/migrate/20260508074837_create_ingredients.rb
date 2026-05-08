class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.timestamps
    end

    add_index :ingredients, :name, unique: true
  end
end
