# == Schema Information
#
# Table name: payments
#
#  id          :bigint           not null, primary key
#  amount_paid :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :bigint           not null, indexed
#  user_id     :bigint           not null, indexed
#
# Indexes
#
#  index_payments_on_order_id  (order_id)
#  index_payments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#
class Payment < ApplicationRecord
  before_validation :set_paid_amount

  attribute :expiry, :date
  attr_accessor :card, :cvc

  belongs_to :user
  belongs_to :order, autosave: true

  validates :amount_paid, presence: true, numericality: { greater_than_or_equal_to: 0.0 }
  validates :card, presence: true, credit_card_number: { brands: [:visa] }
  validates :cvc, presence: true, format: { with: /\d{3}/ }
  validate :future_date

  private

  def future_date
    return if expiry >= Date.current

    errors.add(:expiry, 'card mush not be expired')
  end

  def set_paid_amount
    self.amount_paid = order&.total
  end
end
