class V1::StatusTransitionSerializer < ActiveModel::Serializer
  attributes :id, :event, :from, :to, :created_at, :updated_at
  belongs_to :order
end
