class OrdersCompletionJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    puts '=' * 100
    prepared_orders.each do |order|
      order.completed!

      OrderMailer.with(order: order).prepared.deliver_now
    end
  end

  private

  def prepared_orders
    @prepared_orders ||=
      Order
      .preparing
      .where(expected_at: ..Time.current)
  end
end
