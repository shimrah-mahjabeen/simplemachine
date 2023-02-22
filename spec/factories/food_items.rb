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
FactoryBot.define do
  factory :food_item do
    association :shop, factory: :shops

    name { Faker::Food.dish }
    desc { Faker::Food.description }
    price { Faker::Number.within(range: 1..10) }
    is_available { true }
    category { 0 }
    tax { Faker::Number.within(range: 1..5) }

    trait :free do
      category { 1 }
      price { 0 }
      tax { 0 }
    end
  end
end
