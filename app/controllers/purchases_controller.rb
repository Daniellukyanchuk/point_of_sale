class PurchasesController < ApplicationController
  # before_action :set_purchase, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  before_action :find_products
  
 

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
    @purchase.purchase_products.each do |pp|
      pp.build_product
    end
  end

  # GET /purchases/1/edit
  def edit    
  end

  # POST /purchases or /purchases.json
  def create
    parse_dates
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
      products = CategoryProduct.where("product_category_id = ?", 2)
      product_ids = []
      products.each do |product|
      product_ids.push(product.product_id)
      end
      @raw_products = Product.find(product_ids).sort_by &:product_name
    end

    # parse dates
    def parse_dates     
      params["purchase"]["date_ordered"] = "#{Date.strptime((params["purchase"]["date_ordered"]).to_s, '%m/%d/%Y')}"      
      params["purchase"]["date_received"] = "#{Date.strptime((params["purchase"]["date_received"]).to_s, '%m/%d/%Y')}"     
    end

    # Only allow a list of trusted parameters through.
    def purchase_params      
      ps = params.require(:purchase).permit(:supplier_id, :purchase_total, :date_ordered, :date_received, 
      purchase_products_attributes: [:id, :product_id, :purchase_quantity, :purchase_price, :purchase_subtotal, :_destroy, 
      product_attributes: [:product_name, :price, :unit, :grams_per_unit]])

      ps[:new_product_attributes] = params[:purchase][:purchase_products_attributes].as_json      
      return ps
    end

    def sort_column
      params[:sort] || "created_at"
     end
     
     def sort_direction
       params[:direction] || "asc"
     end        
     
end


