class BillCalculator < ApplicationService
  attr_accessor :cart, :order_items

  def initialize(cart)
    @cart = cart
    @order_items = cart.line_items
  end

  def total
    @total ||= (sub_total + - discount) + total_tax
  end

  def discount
    @discount ||= discounts.reduce(0) do |total_discount, discount|
      discount_amount = discount.discount_item.price * discount.discount_percentage
      discount_amount *= quantity_by_food_item_id(discount.discount_item_id)
      total_discount += discount_amount.round(2)
    end
  end

  def sub_total
    @sub_total ||= food_items.reduce(0) do |total, item|
      next total if item.free?

      total += item.price * quantity_by_food_item_id(item.id)
    end
  end

  private

  def discounts
    @discounts ||= Discount
                   .includes(:discount_item)
                   .where(discount_item: food_items.pluck(:id))
                   .where(discounted_with: food_items.pluck(:id))
  end

  def food_items
    @food_items ||= order_items.includes([:food_item]).map(&:food_item)
  end

  def total_tax
    @total_tax ||= food_items.sum(&:tax)
  end

  def quantity_by_food_item_id(food_item_id)
    @quantity_by_food_item_id ||=
      order_items
      .map { |order_item| [order_item.food_item_id, order_item.quantity] }.to_h

    @quantity_by_food_item_id.fetch(food_item_id, 1)
  end
end
