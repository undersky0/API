class V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :net_price, :created_at, :updated_at
end
