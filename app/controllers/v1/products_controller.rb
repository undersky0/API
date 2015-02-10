class V1::ProductsController < ApplicationController
   before_filter :restrict_access, except: [:update, :destroy]
  # GET /v1/products
  # GET /v1/products.json
# 200 - :ok
# 204 - :no_content
# 400 - :bad_request
# 403 - :forbidden
# 401 - :unauthorized
# 404 - :not_found
# 410 - :gone
# 422 - :unprocessable_entity
# 500 - :internal_server_error
  def index
    @products = Product.all
    if @products.empty?
    render json: @products, message: 'Resource not found', status: 404
    else
      render json: @products, message: 'OK', status: 200
    end
  end

  # GET /v1/products/1
  # GET /v1/products/1.json
  def show
    @product = Product.find(params[:id])

    render json: @product
  end

  # POST /v1/products
  # POST /v1/products.json
  def create
    @itemline = ItemLine.new(:net_price => params[:net_price])
    @product = @itemline.build_product(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/products/1
  # PATCH/PUT /v1/products/1.json
  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      head :no_content
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/products/1
  # DELETE /v1/products/1.json
  def destroy
    @product = Product.find(params[:id])
    if @product.try(:item_line).try(:order).nil?
      @product.destroy
      head :no_content
    else
      render json: {message: 'Someone has ordered this product'}, status: 401
    end
  end

  private
    
    def product_params
      params.require(:product).permit(:name, :net_price, :item_line_id, :item_line => [:quantity, :net_price])
    end
end
