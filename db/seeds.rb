# This is not the place for test data
# Only use this to put the necessary setup for the app to work
# Separate the seeds in different Seed Service Objects
# The data can then be loaded with the rails db:seed command

admin_1 = FactoryBot.create(:user, :admin, email: 'admin+1@shop.com')
admin_2 = FactoryBot.create(:user, :admin, email: 'admin+2@shop.com')

1..5.each do |number|
  FactoryBot.create(:user, email: "customer+#{number}@shop.com")
end

1..5.each { FactoryBot.create(:food_item, shop: admin_1.shop) }
1..5.each { FactoryBot.create(:food_item, shop: admin_2.shop) }

FactoryBot.create(:food_item, :free, shop: admin_1.shop)
FactoryBot.create(:food_item, :free, shop: admin_2.shop)
