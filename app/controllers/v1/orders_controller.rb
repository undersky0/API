class V1::OrdersController < ApplicationController
  # GET /v1/orders
  # GET /v1/orders.json

  def index
    @orders = Order.all
    if @orders.nil?
      render json: @orders, message: 'Resource not found', status: 404
    else
      render json: @orders, message: 'OK', status: 200
    end
  end

  # GET /v1/orders/1
  # GET /v1/orders/1.json
  def show
    @order = Order.find(params[:id])

   if @order.nil?
      render json: @order, message: 'Resource not found', status: 404
   else
      render json: @order, message: 'OK', status: 200
   end
  end

  # POST /v1/orders
  # POST /v1/orders.json
  def create
      @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :OK, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/orders/1
  # PATCH/PUT /v1/orders/1.json
  def update
    @order = Order.find(params[:id])
    case @order.state
    when 0
    if @order.update(order_params)
      head :no_content
    else
      render json: @order.errors, status: :unprocessable_entity
    end
    else
      render json: {message: 'Can be edited only when in draft(0) state'}, status: 400
    end
      
  end

  # DELETE /v1/orders/1
  # DELETE /v1/orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    head :no_content
  end

  private    
    def order_params
      params.require(:order).permit(:state, :vat, :order_date, :user_id, :item_lines_attributes => [:id, :quantity, :net_price])
    end

    
end
