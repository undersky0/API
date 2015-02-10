class ItemLine < ActiveRecord::Base
  belongs_to :order
  has_one :product
  accepts_nested_attributes_for :product, :order
  validates_numericality_of :net_price, :message => 'is not a number'
  validates_numericality_of :quantity, :message => 'is not a number'
end
