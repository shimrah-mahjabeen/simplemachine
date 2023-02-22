json.status 200
json.user do
  json.partial! 'api/v1/users/minimal.json.jbuilder', user: @resource
  json.shop do
    json.name @resource.shop.shop_name.capitalize
  end
end
