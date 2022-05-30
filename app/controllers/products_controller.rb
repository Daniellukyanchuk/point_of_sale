class ProductsController < ApplicationController
  # before_action :set_product, only: %i[ show edit update destroy ]
  load_and_authorize_resource  
  helper_method :sort_column, :sort_direction
  
def get_price
  @price = Product.where("id = ?", params[:product_id]).first.price
  render json: {price: @price}
end

def get_unit
  @unit = Product.where("id = ?", params[:id]).first.unit
  render json: {unit: @unit}
end

def get_recipe_info
    @price_per_kg = Product.get_price_per_kg(params[:id].to_i)
    if !@price_per_kg.first.blank?
    render json: {price_per_kg: @price_per_kg.first["weighted_price_per_kg"] }
    else @price_per_kg.first == 0
  end
end

  # GET /products or /products.json
  def index
    @products = Product.search(params[:search]).order(sort_column + " " + sort_direction).includes(:product_categories)
      respond_to do |format|
        format.xlsx {
          response.headers[
            'Content-Disposition'
          ] = "attachment; filename=products.xlsx"
        }
        format.html { render :index }
      end
  end

  

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new    
    @product = Product.new
    set_product_categories
  end

  # GET /products/1/edit
  def edit
    set_product_categories
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.add_product_categories(params)
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.update_product_categories(params)
        format.html { redirect_to products_path, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      stop
      @product = Product.find(params[:id])
    end

    def set_product_categories
      @product_categories = ProductCategory.all
    end

   

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:id, :product_name, :price, :unit, :units_purchased, :units_sold, :inventory, :grams_per_unit, category_products_attributes: [:product_category_id, :product_id])
    end

    def sort_column
      params[:sort] || "price"
    end
    
    def sort_direction
      params[:direction] || "desc"
    end        

end
