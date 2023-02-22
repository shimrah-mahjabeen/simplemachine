json.status 200

json.body do
  json.shops do
    json.partial! 'api/v1/shops/minimal.json.jbuilder', collection: @shops, as: :shop
  end

  json.total_shops @pagy.count

  json.next_page next_page_url(@pagy)

  json.prev_page prev_page_url(@pagy)
end
