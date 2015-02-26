require 'rails_helper'
require 'spec_helper'
RSpec.describe KeyGenerator do
  
  it "should generate a random token" do 
    s = SecureRandom.hex.to_s
    expect(s).to be_s
  end

end