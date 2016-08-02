class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  expose(:product)
  expose(:products) { Product.all }
  expose(:id) { params[:id] }
  expose(:name) { params[:name] }
  expose(:type) { params[:type] }
  expose(:length) { params[:length] }
  expose(:width) { params[:width] }
  expose(:height) { params[:height] }
  expose(:weight) { params[:weight] }

  expose(:product_params) {
    {
        name: name,
        type: type,
        length: length,
        width: width,
        height: height,
        weight: weight
    }
  }
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_path, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created }
      else
        format.html { render :new }
        format.json { render json: {message: @product.errors}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_path, notice: 'Product was successfully updated.' }
        format.json { render json: @product, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    message = @product.name + ' was deleted'
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_path, notice: 'Product was successfully deleted.' }
      format.json { render json: {message: message} }
    end
  end

  def calculate_measurements_match
    measurement_match = Product.dimensions(length, width, height, weight)
    render json: measurement_match ? {message: measurement_match.name} : "There are no matches for these measurments"

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :type, :length, :width, :height, :weight)
  end

end
