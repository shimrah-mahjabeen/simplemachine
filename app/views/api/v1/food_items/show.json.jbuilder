json.status 200

json.body do
  json.food_item do
    json.partial! 'api/v1/food_items/minimal.json.jbuilder', food_item: @food_item
  end
end
