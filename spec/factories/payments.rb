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
FactoryBot.define do
  factory :payment do
    user { nil }
    order { nil }
    amount_paid { 1.5 }
  end
end
