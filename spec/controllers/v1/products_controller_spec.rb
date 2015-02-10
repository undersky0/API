require 'rails_helper'
require 'spec_helper'
require 'api_helper'

RSpec.describe V1::ProductsController, :type => :controller do
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }
  let(:valid_session) { {} }
  
  before(:each) do |example|
    @user = FactoryGirl.create(:user)
    unless example.metadata[:skip_before]
    @product = FactoryGirl.create(:product)
    @product2 = FactoryGirl.create(:product, net_price: '10')
    @itemline = FactoryGirl.create(:item_line)
    end
  end
  

  describe "GET index" do
    it "assigns all products as @products" do
      get :index, {token: @user.api_key.token}
      expect(assigns(:products)).to match_array([@product, @product2])
      expect(response.status).to eq 200
      puts "index:  + #{response.body}"
    end 
    
  end

  describe "GET show" do
    it "assigns the requested product as @product" do
    response = get :show, {:id => @product.id, token: @user.api_key.token}
    puts "show:  + #{JSON.parse(response.body)}"
    expect(response.status).to eq 200
    end
  end


  describe "GET edit" do
    it "assigns the requested v1_product as @v1_product" do

    end
  end

  describe "POST create", :skip_before do
    before :each do 
      @products = FactoryGirl.attributes_for(:product)
    end
    
    describe "with valid params" do
      xit "creates a new Product" do
        @itemline = FactoryGirl.create(:item_line)
        expect {
          post :create, :product => {name: "test1", net_price: 101, item_line_id: @itemline.id}, token: @user.api_key.token
        }.to change(Product, :count).by(1)
        expect(Product.last.name).to eq "test1"
        expect(Product.last.net_price).to eq 101
        expect(response.status).to eq 201
        expect(response.message).to eq "Created"
      end
      it "fails without token" do
        expect {
          post :create, :product => {name: "test", net_price: 10 }
        }.to change(Product, :count).by(0)
        expect(response.status).to eq 401
        expect(response.message).to eq "Unauthorized"
        r = JSON.parse(response.body)
        expect(r["message"]).to eq "Invalid API Token"
        puts "RESPONSE STATUS: #{response.status} message #{response.message} m #{response.body}"
      end
      it "name & price not uniq" do
        FactoryGirl.create(:product, name: "test", net_price: 10)
        expect {
          post :create, :product => {name: "test", net_price: 10 }, token: @user.api_key.token
        }.to change(Product, :count).by(0)
        r = JSON.parse(response.body)
        expect(r["name"]).to eq ["must be unique"]
        expect(r["net_price"]).to eq ["must be unique"]
        expect(response.status).to eq 422
        puts response.status
      end       
      
      it "product belongs_to itemline",:skip_before do
          @itemline = FactoryGirl.create(:item_line)
          @product = FactoryGirl.create(:product, item_line: @itemline)
          expect(@product.item_line_id).to eq 1
      end
        

      it "assigns a newly created v1_product as @v1_product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end
      
      it "redirects to the created v1_product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(response).to redirect_to(Product.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved v1_product as @v1_product" do
        post :create, {:product => invalid_attributes}, valid_session
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {:product => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {name: "teststs"}
      }

      it "updates the requested v1_product" do  
        put :update, {:id => @product, :product => new_attributes}, token: @user.api_key.token
        puts response.body.inspect
        @product.reload
        expect(@product.name).to eq "teststs"
      end

      it "assigns the requested v1_product as @v1_product" do
        product = Product.create! valid_attributes
        put :update, {:id => @product, :product => new_attributes}, token: @user.api_key.token
        expect(assigns(:product)).to eq(@product)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested v1_product" do
      product = @product
      expect {
        delete :destroy, {:id => product.to_param}, token: @user.api_key.token
      }.to change(Product, :count).by(-1)
    end
  end
  
  describe "INVALID DELETE", :skip_before do
    it "returns status 401" do
      product = FactoryGirl.create(:product, name: "dsadsa", net_price: 321, item_line_id: 1)
      FactoryGirl.create(:order)
      FactoryGirl.create(:item_line, quantity: 2, order_id: 1)
      expect {
        delete :destroy, {:id => product.to_param}, token: @user.api_key.token
      }.to change(Product, :count).by(0)
      expect(response.status).to eq 401
      r = JSON.parse(response.body)
      expect(r["message"]).to eq "Someone has ordered this product"
    end
    end
  end

