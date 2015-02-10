require 'rails_helper'
require 'spec_helper'
RSpec.describe ApiKey, :type => :model do
  it {should belong_to(:user)}
  
  context "Created on User.create"
end
