json.status 200

json.body do
  json.cart_item do
    json.partial! 'api/v1/cart_items/minimal.json.jbuilder', cart_item: @cart_item
  end
end
