class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction


def import
  Product.import(params[:file])
  redirect_to root_url, notice: "Products imported successfully!"
end
  
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
    @products = Product.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
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
        format.html { redirect_to @product, notice: "Product was successfully updated." }
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
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:id, :product_name, :price, :unit, :units_purchased, :units_sold, :inventory, :grams_per_unit)
    end

    def sort_column
      params[:sort] || "price"
    end
    
    def sort_direction
      params[:direction] || "desc"
    end        

end
