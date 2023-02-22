# == Schema Information
#
# Table name: order_items
#
#  id           :bigint           not null, primary key
#  quantity     :integer
#  sub_total    :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  cart_id      :bigint           indexed
#  food_item_id :bigint           not null, indexed
#  order_id     :bigint           indexed
#
# Indexes
#
#  index_order_items_on_cart_id       (cart_id)
#  index_order_items_on_food_item_id  (food_item_id)
#  index_order_items_on_order_id      (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (food_item_id => food_items.id)
#
FactoryBot.define do
  factory :order_item do
    order { nil }
    food_item { nil }
    quantity { 1 }
    sub_total { 1.5 }
  end
end
