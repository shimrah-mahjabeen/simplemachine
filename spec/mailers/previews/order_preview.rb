# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview
  def prepared
    order = FactoryBot.create(:order)

    OrderMailer.with(order: order).prepared
  end
end
