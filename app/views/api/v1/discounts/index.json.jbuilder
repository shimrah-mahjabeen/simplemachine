json.status 200

json.body do
  json.discounts do
    json.partial! 'api/v1/discounts/minimal.json.jbuilder', collection: @discounts, as: :discount
  end

  json.total_discounts @pagy.count

  json.next_page next_page_url(@pagy)

  json.prev_page prev_page_url(@pagy)
end
