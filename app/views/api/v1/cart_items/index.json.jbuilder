json.status 200

json.body do
  json.cart_items do
    json.partial! 'api/v1/cart_items/minimal.json.jbuilder', collection: @cart_items, as: :cart_item
  end

  json.sub_total bill_calculator.sub_total
  json.discount bill_calculator.discount
  json.total_bill bill_calculator.total

  json.total_items @pagy.count

  json.next_page next_page_url(@pagy)

  json.prev_page prev_page_url(@pagy)
end
