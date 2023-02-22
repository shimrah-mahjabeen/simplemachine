json.status 200

json.body do
  json.food_items do
    json.partial! 'api/v1/food_items/minimal.json.jbuilder', collection: @food_items, as: :food_item
  end

  json.total_items @pagy.count

  json.next_page next_page_url(@pagy)

  json.prev_page prev_page_url(@pagy)
end
