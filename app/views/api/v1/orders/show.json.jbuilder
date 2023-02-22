json.status 200

json.body do
  json.order do
    json.partial! 'api/v1/orders/minimal.json.jbuilder', order: @order
  end
end
