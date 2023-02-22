json.status 200

json.body do
  json.orders do
    json.partial! 'api/v1/orders/minimal.json.jbuilder', collection: @orders, as: :order
  end

  json.total_orders @pagy.count

  json.next_page next_page_url(@pagy)

  json.prev_page prev_page_url(@pagy)
end
