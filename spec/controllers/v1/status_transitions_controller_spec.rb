require 'rails_helper'

RSpec.describe V1::StatusTransitionsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # V1::StatusTransition. As you add validations to V1::StatusTransition, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # V1::StatusTransitionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  
  before(:each) do |t|
    unless t.metadata[:skip_before]
      @order = FactoryGirl.create(:order)
      @status = FactoryGirl.build(:status_transition)
      
    end
  end

  describe "GET index", :skip_before do
    it "assigns the requested status_transition as @status_transition" do
      @order = FactoryGirl.create(:order)
      get :index, :order_id => @order.id
      expect(response.status).to eq(200)
    end
    
    it "updates to place" do
      @order = FactoryGirl.create(:order)
      get :index, :order_id => @order.id, :event => "place"
      @order.reload
      expect(@order.status_transition.event).to eq "place"
    end
    it "updates to pay fails" do
      @order = FactoryGirl.create(:order)
      get :index, :order_id => @order.id, :event => "pay"
      @order.reload
      expect(@order.status_transition.event).to eq nil
    end
    it "updates to pay " do
      @order = FactoryGirl.create(:order, state: 1)
      get :index, :order_id => @order.id, :event => "pay"
      @order.reload
      expect(@order.status_transition.event).to eq "pay"
    end
    it "updates to cancel " do
      @order = FactoryGirl.create(:order, state: 1)
      get :index, :order_id => @order.id, :event => "cancel", :reason => "dsadsa"
      @order.reload
      expect(@order.status_transition.event).to eq "cancel"
    end
  end


end
