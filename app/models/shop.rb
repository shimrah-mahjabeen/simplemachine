# == Schema Information
#
# Table name: shops
#
#  id         :bigint           not null, primary key
#  shop_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null, indexed
#
# Indexes
#
#  index_shops_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Shop < ApplicationRecord
  belongs_to :user
  has_many :discounts, dependent: :destroy
  has_many :food_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :shop_name, presence: true
end
