# == Schema Information
#
# Table name: discounts
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE), not null
#  desc                :string
#  discount_percentage :float            default(0.0), not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  discount_item_id    :bigint           not null, indexed
#  discounted_with_id  :bigint           not null, indexed
#  shop_id             :bigint           default(1), not null, indexed
#
# Indexes
#
#  index_discounts_on_discount_item_id    (discount_item_id)
#  index_discounts_on_discounted_with_id  (discounted_with_id)
#  index_discounts_on_shop_id             (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (discount_item_id => food_items.id)
#  fk_rails_...  (discounted_with_id => food_items.id)
#
FactoryBot.define do
  factory :discount do
    association :discount_item, factory: :food_items
    association :discounted_with, factory: :food_items
    association :shop, factory: :shops

    name { 'MyString' }
    desc { 'MyString' }
    discount_percentage { 1.5 }
    active { false }
  end
end
