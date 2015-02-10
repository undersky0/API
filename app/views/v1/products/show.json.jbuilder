product ||= @product

json.id product['id']
json.name product['name']
json.net_price product['net_price']
json.create_at product['create_at']
json.updated_at product['updated_at']
if product.class == Hash
    json.active
  Product.find(product['id']).active_for_user?(@api_key.user)
  else
    json.active product.active_for_user?(@api_key.user)
  end

  if product.class == ActiveRecord::Base && !product.persisted? &&
  !product.valid?
    json.errors product.errors.messages
  end
