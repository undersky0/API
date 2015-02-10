require 'rails_helper'

RSpec.describe StatusTransition, :type => :model do
  it {should belong_to(:order)}
end
