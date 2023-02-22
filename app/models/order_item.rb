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
class OrderItem < ApplicationRecord
  before_save :calculate_sub_total

  belongs_to :order, optional: true
  belongs_to :cart, optional: true
  belongs_to :food_item

  validates :food_item, uniqueness: { scope: %i[order_id cart_id] }
  validates :order, presence: :true, unless: -> { cart_id? }
  validates :cart_id, presence: :true, unless: -> { order_id? }
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  private

  def calculate_sub_total
    self.sub_total = quantity * food_item.price
  end
end
