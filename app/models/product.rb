class Product < ActiveRecord::Base
  validates_uniqueness_of :name, :on => :create, :message => 'must be unique'
  validates_uniqueness_of :net_price, :on => :create, :message => 'must be unique'
  belongs_to :item_line
  accepts_nested_attributes_for :item_line
  
  
end
