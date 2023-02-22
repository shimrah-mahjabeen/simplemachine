json.status 200

json.body do
  json.shop do
    json.partial! 'api/v1/shops/minimal.json.jbuilder', shop: @shop
  end
end
