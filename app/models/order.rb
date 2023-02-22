# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  expected_at :datetime
#  status      :integer
#  total       :float            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  shop_id     :bigint           not null, indexed
#  user_id     :bigint           not null, indexed
#
# Indexes
#
#  index_orders_on_shop_id  (shop_id)
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :shop
  has_one :user, through: :shop
  has_one :payment, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validate :has_paid_items
  validate :is_empty?

  enum status: {
    waiting_for_payment: 0,
    verifying_payment: 1,
    placed: 2,
    preparing: 3,
    payment_declined: 4,
    on_hold: 5,
    rejected: 6,
    completed: 7
  }

  scope :for_shop_user, ->(user_id) { joins(:shop).where(shop: { user_id: user_id }) }

  private

  def has_paid_items
    return if order_items.any? { |order_item| order_item.food_item.paid? }

    errors.add(:order_items, 'order should have at least one paid item')
  end

  def is_empty?
    return unless order_items.empty?

    errors.add(:order_items, "can't place an empty order")
  end
end
