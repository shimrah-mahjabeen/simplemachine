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
FactoryBot.define do
  factory :order do
    association :user, factory: :user

    expected_at { 30.minutes.from_now }
    total { 1 }
  end
end
