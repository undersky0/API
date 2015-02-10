json.array!(@status_transitions) do |status_transition|
  json.extract! status_transition, :id, :event, :from, :to, :order_id
  json.url status_transition_url(status_transition, format: :json)
end
