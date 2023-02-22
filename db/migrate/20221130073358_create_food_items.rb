class CreateFoodItems < ActiveRecord::Migration[6.1]
  def change
    create_table :food_items do |t|
      t.string :name, null: false
      t.string :desc, null: false, default: ""
      t.float :price, null: false, default: 0.0
      t.boolean :is_available, null: false, default: true
      t.integer :category, null: false, default: 0
      t.float :tax, null: false, default: 0.0
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
