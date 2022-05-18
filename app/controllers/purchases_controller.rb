class PurchasesController < ApplicationController
  # before_action :set_purchase, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  before_action :find_products

  def get_product_info
    @purchase_product_data = PurchaseProduct.find(params[:id].to_i) 
    render json: {qt: @purchase_product_data.purchase_quantity, cost: @purchase_product_data.purchase_price, product_name: @purchase_product_data.product.product_name, 
      supplier: @purchase_product_data.purchase.supplier.supplier_name, subtotal: @purchase_product_data.purchase_subtotal, purchase_id: @purchase_product_data.purchase_id, 
      product_id: @purchase_product_data.product_id }
  end
 

  # GET /purchases or /purchases.json
  def index
    @purchases = Purchase.order(sort_column + " " + sort_direction)
  end

  # GET /purchases/1 or /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new
    @purchase.purchase_products.new
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases or /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: "purchases were successfully added to inventory." }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1 or /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1 or /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: "purchase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def find_products
      products = CategoryProduct.where("product_category_id = ?", 12)
      product_ids = []
      products.each do |product|
        product_ids.push(product.product_id)
      end
      @raw_products = Product.find(product_ids).sort_by &:product_name
    end

    # Only allow a list of trusted parameters through.
    def purchase_params
      params.require(:purchase).permit(:supplier_id, :purchase_total, :estimated_total, :date_ordered, 
        :date_expected, :date_received, :purchase_product_id, 
        purchase_products_attributes: [:id, :product_id, :purchase_id, :purchase_quantity, :purchase_price, :purchase_subtotal, :estimated_quantity, :estimated_cost, :estimated_subtotal, :_destroy])
    end

    def sort_column
      params[:sort] || "created_at"
     end
     
     def sort_direction
       params[:direction] || "asc"
     end        
     
end


