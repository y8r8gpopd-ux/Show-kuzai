class CreateFridgeItems < ActiveRecord::Migration[7.1]
  def change
    create_table :fridge_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :quantity
      t.integer :unit_id
      t.date :purchased_at, null: false
      t.timestamps
    end
  end
end
