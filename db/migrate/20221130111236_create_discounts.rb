class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :desc
      t.boolean :active, null: false, default: true
      t.float :discount_percentage, null: false, default: 0.0
      t.references :discount_item, null: false, foreign_key: { to_table: :food_items }
      t.references :discounted_with, null: false, foreign_key: { to_table: :food_items }

      t.timestamps
    end
  end
end
