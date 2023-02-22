class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: true
      t.references :cart, null: true
      t.references :food_item, null: false, foreign_key: true
      t.integer :quantity
      t.float :sub_total

      t.timestamps
    end
  end
end
