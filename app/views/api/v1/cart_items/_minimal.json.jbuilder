json.id cart_item.hashid
json.food_item_id cart_item.food_item_id
json.price cart_item.food_item.price
json.quantity cart_item.quantity
json.sub_total cart_item.sub_total
json.cart_id cart_item.cart_id if cart_item.cart_id?
json.order_id cart_item.order_id if cart_item.order_id?
