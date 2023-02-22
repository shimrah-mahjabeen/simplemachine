json.status 200

json.body do
  json.discount do
    json.partial! 'api/v1/discounts/minimal.json.jbuilder', discount: @discount
  end
end
