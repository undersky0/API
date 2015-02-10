class V1::ItemLineSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :net_price
  has_one :product
  belongs_to :order
end
