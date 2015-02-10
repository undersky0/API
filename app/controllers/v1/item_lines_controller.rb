class V1::ItemLinesController < ApplicationController
  # GET /v1/item_lines
  # GET /v1/item_lines.json
  def index
    @item_lines = ItemLine.all

    render json: @item_lines
  end

  # GET /v1/item_lines/1
  # GET /v1/item_lines/1.json
  def show
    @item_lines = ItemLine.find(params[:id])

    render json: @item_lines
  end

  # POST /v1/item_lines
  # POST /v1/item_lines.json
  def create
    @item_lines = ItemLine.new(item_line_params)

    if @item_lines.save
      render json: @item_lines, status: :created, location: @item_lines
    else
      render json: @item_lines.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/item_lines/1
  # PATCH/PUT /v1/item_lines/1.json
  def update
    @item_lines = ItemLine.find(params[:id])

    if @item_lines.update(item_line_params)
      head :no_content
    else
      render json: @item_lines.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/item_lines/1
  # DELETE /v1/item_lines/1.json
  def destroy
    @item_lines = ItemLine.find(params[:id])
    @item_lines.destroy

    head :no_content
  end

  private
    
    def item_line_params
      params.require(:item_line).permit(:quantity, :net_price, :product_id, :order_id, product_attributes: [:name, :net_price])
    end
end
