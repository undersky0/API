json.array!(@item_lines) do |item_line|
  json.extract! item_line, :id, :quantity, :net_price, :product_id, :order_id
  json.url item_line_url(item_line, format: :json)
end
