# == Schema Information
#
# Table name: food_items
#
#  id           :bigint           not null, primary key
#  category     :integer          default("paid"), not null
#  desc         :string           default(""), not null
#  is_available :boolean          default(TRUE), not null
#  name         :string           not null
#  price        :float            default(0.0), not null
#  tax          :float            default(0.0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  shop_id      :bigint           not null, indexed
#
# Indexes
#
#  index_food_items_on_shop_id  (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#
class FoodItem < ApplicationRecord
  belongs_to :shop
  has_many :discounts, foreign_key: :discount_item_id, dependent: :destroy
  has_many :discounted_with, through: :discounts, dependent: :destroy

  validates :name, presence: true
  validates :desc, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :tax, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validate :is_free?
  validate :is_paid?

  enum category: {
    paid: 0,
    free: 1
  }

  scope :available, -> { where(is_available: true) }

  private

  def is_free?
    return unless free? && price.positive?

    errors.add(:category, "free item's price must be zero")
  end

  def is_paid?
    return unless paid? && price.zero?

    errors.add(:category, "paid item's price must not be zero")
  end
end
