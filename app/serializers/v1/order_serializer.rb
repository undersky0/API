class V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :state, :user_id, :vat, :created_at, :updated_at
  has_many :item_lines
  has_one :status_transition
end

