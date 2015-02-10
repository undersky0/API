class V1::StatusTransitionsController < ApplicationController

  def index
    @order = Order.find(params[:order_id])
    @status_transition = @order.status_transition
    if params[:event].present?    
    case params[:event]
      when "place"
      @order.place
      puts "placed"
      render json: {message: "Order placed"}, status: 200
    when "pay"
      @order.pay
      render json: {message: "Order payed"}, status: 200
    when "cancel"
      if params[:reason].present?
      @order.cancel
      render json: {message: "Order Canceled"}, status: 200
      else
        render json: {message: "Please include :reason"}
      end
    end
    else
    render json: @status_transition, status: 200
    end
  end


  # PATCH/PUT /v1/status_transitions/1
  # PATCH/PUT /v1/status_transitions/1.json
  def update
    if params[:order_id].present?
      @order = Order.find(params[:order_id])
    else
    @status_transition = StatusTransition.find(params[:id])
    @order = @status_transition.order
    end
    case params[:status_transition][:event]
    when "place"
      @order.place
      render json: {message: "Order placed"}, status: 200
    when "pay"
      @order.pay
      render json: {message: "Order payed"}, status: 200
    when "cancel"
      @order.cancel
      render json: {message: "Order Canceled"}, status: 200
    end
  end


  private
    
    def status_transition_params
      params.require(:status_transition).permit(:event, :order_id)
    end
end
