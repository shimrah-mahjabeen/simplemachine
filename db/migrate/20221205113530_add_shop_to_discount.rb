class AddShopToDiscount < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_reference :discounts, :shop, null: false, index: {algorithm: :concurrently}
  end
end
