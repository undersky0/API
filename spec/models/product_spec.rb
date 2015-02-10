require 'rails_helper'

RSpec.describe Product, :type => :model do
 it {should belong_to(:item_line)}
 it {should validate_uniqueness_of(:name).with_message('must be unique')}
 it {should validate_uniqueness_of(:net_price).with_message('must be unique')}  
 
 
end
