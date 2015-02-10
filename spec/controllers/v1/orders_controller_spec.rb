require 'rails_helper'
require 'spec_helper'
require 'api_helper'

RSpec.describe V1::OrdersController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Order. As you add validations to Order, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OrdersController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  
  
  before(:each) do 
    @user = FactoryGirl.create(:user)
    @order = FactoryGirl.create(:order)
  end
  
  it 'should return a single order' do

  end
  

  describe "GET index" do
    it "assigns all orders as @orders" do
      order = Order.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:orders)).to eq([order])
    end
  end

  describe "GET show" do
    it "assigns the requested order as @order" do
     response = get :show, {:id => @order.id}, token: @user.api_key.token
     #get "orders/#{@order.id}", {token: @user.api_key.token}
    # puts JSON.parse(response.body)
     expect(response.status).to eq 200
    end
  end

  # describe "GET new" do
    # it "assigns a new order as @order" do
      # get :new, {}, valid_session
      # expect(assigns(:order)).to be_a_new(Order)
    # end
  # end

  describe "GET edit" do
    it "assigns the requested order as @order" do
      order = Order.create! valid_attributes
      get :edit, {:id => order.to_param}, valid_session
      expect(assigns(:order)).to eq(order)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "create a new line item with order" do
        expect {
          post :create, 
          order: FactoryGirl.attributes_for(:order, state: 0,
          item_lines_attributes: [:quantity => 2, :net_price => 10.1]), token: @user.api_key.token
        }.to change(Order, :count).by(1)
        expect(ItemLine.last.quantity).to eq 2
        expect(ItemLine.last.net_price).to eq 10.1
      end
       
      
      it "creates a new Order" do
        expect {
          post :create, {:order => valid_attributes}, valid_session
        }.to change(Order, :count).by(1)
      end

      it "assigns a newly created order as @order" do
        post :create, {:order => valid_attributes}, valid_session
        expect(assigns(:order)).to be_a(Order)
        expect(assigns(:order)).to be_persisted
      end

      it "redirects to the created order" do
        post :create, {:order => valid_attributes}, valid_session
        expect(response).to redirect_to(Order.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved order as @order" do
        post :create, {:order => invalid_attributes}, valid_session
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "re-renders the 'new' template" do
        post :create, {:order => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }
      
      before(:each) do
        @order = FactoryGirl.create(:order)
        @item = FactoryGirl.create(:item_line, order_id: @order.id)
        @item2 = FactoryGirl.create(:item_line, order_id: @order.id)
        @item3 = FactoryGirl.attributes_for(:item_line, order_id: @order.id)
      end

      it "updates the requested order" do
        order = FactoryGirl.create(:order)
        put :update, {:id => order.id, :order => {vat: 10, state: 1}}, token: @user.api_key.token
        order.reload
        expect(order.vat).to eq 10
      end
      
      it "updates line item" do
        @order2 = FactoryGirl.create(:order, state: 1)
        @item = FactoryGirl.create(:item_line, order_id: @order2.id)
        @item2 = FactoryGirl.create(:item_line, order_id: @order2.id)
        put :update,  :id => @order2.id, :order => {item_lines_attributes: [:id => 2, :quantity => 4, :net_price => 80.1]}, token: @user.api_key.token
        @order2.reload
        @item2.reload
        r = JSON.parse(response.body)
        expect(r["message"]).to eq "Can be edited only when in draft(0) state"
        expect(response.status).to eq 400
      end
      
      it "update line item invalid" do
        @order2 = FactoryGirl.create(:order, state: 0)
        @item = FactoryGirl.create(:item_line, order_id: @order2.id)
        @item2 = FactoryGirl.create(:item_line, order_id: @order2.id)
        put :update,  :id => @order2.id, :order => {vat: "dsadas", item_lines_attributes: [:id => @item.id, :quantity => "invalid", :net_price => 80.1]}, token: @user.api_key.token
        @order2.reload
        @item.reload
        expect(response.status).to eq 422 
      end
      
      it "can only be edit in draft state" do
         put :update,  :id => @order.id, :order => {item_lines_attributes: [:id => @item2.id, :quantity => 4, :net_price => 80.1]}, token: @user.api_key.token
         @order.reload
         @item2.reload
         expect(@item2.net_price).to eq 80.1.to_d
         expect(@item2.quantity).to eq 4
      end
      

      it "assigns the requested order as @order" do

        put :update, {:id => @order.to_param, :order => valid_attributes}, valid_session
        expect(assigns(:order)).to eq(order)
      end
    end

    describe "with invalid params" do
      it "assigns the order as @order" do
        put :update, {:id => @order.to_param, :order => {vat:"invalid"}}, valid_session
        expect(assigns(:order)).to eq(@order)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested order" do
      expect {
        delete :destroy, {:id => @order.id}, valid_session
      }.to change(Order, :count).by(-1)
    end
  end

end
