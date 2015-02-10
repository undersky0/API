require 'rails_helper'
require 'spec_helper'
require 'api_helper'
RSpec.describe Order, :type => :model do
  it {should belong_to(:user)}
  it {should have_many(:item_lines)}
  it {should have_one(:status_transition)}
  it {should accept_nested_attributes_for(:item_lines)}
  it {should accept_nested_attributes_for(:status_transition)}
  it {should validate_numericality_of(:vat).with_message('is not a number')}
  
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order)
    @transition = FactoryGirl.create(:status_transition, order_id: @order.id)
  end
  
  context "Testing state machine" do 
  it "should change state from 0 to 1" do 
    expect{@order.place}.to change{@order.state}.from(0).to(1)
  end
  
  it "should change state from 0 to 1 to 2" do
    expect{@order.place}.to change{@order.state}.from(0).to(1)
    
    expect([@order.status_transition.event, @order.status_transition.from,
      @order.status_transition.to]).to contain_exactly(:place,:draft,:placed)
      
    expect{@order.pay}.to change{@order.state}.from(1).to(2)
    expect([@order.status_transition.event, @order.status_transition.from,
      @order.status_transition.to]).to contain_exactly(:pay,:placed,:paid)
      
    expect{@order.cancel}.not_to change{@order.state} 
  end
  
  end
  

end
