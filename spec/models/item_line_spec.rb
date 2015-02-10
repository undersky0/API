require 'rails_helper'
require 'spec_helper'
RSpec.describe ItemLine, :type => :model do
  it {should belong_to(:order)}
  it {should have_one(:product)}
  it {should validate_numericality_of(:net_price).with_message('is not a number')}
  it {should validate_numericality_of(:quantity).with_message('is not a number')}
#   
  # f = FactoryGirl.create(:line_with_order)
  # d = FactoryGirl.create(:product_with_line)
  # puts f.inspect
  # puts d.inspect
end
