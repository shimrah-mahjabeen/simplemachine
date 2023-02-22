json.status 200

json.body do
  json.book do
    json.partial! 'api/v1/books/minimal.json.jbuilder', book: @item.book
  end

  json.paid @item.book.price
end
