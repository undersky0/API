require 'rails_helper'

RSpec.describe User, :type => :model do
  it {should have_one(:api_key)}
  
  it "should have api_key after save" do
    u = FactoryGirl.create(:user)
    puts u.api_key.token
    expect(u.api_key.token).not_to be_nil
  end
end  
