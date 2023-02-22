class FinalizeOrderService < ApplicationService
  attr_accessor :user, :cart, :bill_calculator, :order, :payment

  def initialize(user, cart, payment)
    @user = user
    @cart = cart
    @order = nil
    @payment = payment
    @bill_calculator = BillCalculator.new(cart)
  end

  def call
    ActiveRecord::Base.transaction do
      payment.create_order!(
        user: user,
        shop: cart.shop,
        status: :preparing,
        total: bill_calculator.total,
        order_items: cart.line_items,
        expected_at: 30.minutes.from_now
      )

      cart.line_items.update_all(cart_id: nil)
    end

  rescue => e

    @errors << e.message
  end

  private

  def cart_items_by_shop
    @cart_items_by_shop ||=
      @cart
      .line_items
      .joins(:food_item)
      .group_by { |line_item| line_item.food_item.shop }
  end
end
