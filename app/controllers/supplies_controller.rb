class SuppliesController < ApplicationController
  before_action :set_supply, only: %i[ show edit update destroy ]


  def get_product_info
    supply_product_id = params[:id]
    @supply_product_data = SupplyProduct.find(supply_product_id.to_i) 
    render json: {qt: @supply_product_data.purchase_quantity, cost: @supply_product_data.purchase_price, product_name: @supply_product_data.product.product_name,
      supplier: @supply_product_data.supply.supplier.supplier_name, subtotal: @supply_product_data.purchase_subtotal, supply_id: @supply_product_data.supply_id, 
      product_id: @supply_product_data.product_id }
  end
 

  # GET /supplies or /supplies.json
  def index
    @supplies = Supply.order(sort_column + " " + sort_direction)
  end

  # GET /supplies/1 or /supplies/1.json
  def show
  end

  # GET /supplies/new
  def new
    @supply = Supply.new
    @supply.supply_products.new
  end

  # GET /supplies/1/edit
  def edit
  end

  # POST /supplies or /supplies.json
  def create
    @supply = Supply.new(supply_params)
    

    respond_to do |format|
      if @supply.save
        format.html { redirect_to @supply, notice: "Supplies were successfully added to inventory." }
        format.json { render :show, status: :created, location: @supply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplies/1 or /supplies/1.json
  def update
    respond_to do |format|
      if @supply.update(supply_params)
        format.html { redirect_to @supply, notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @supply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplies/1 or /supplies/1.json
  def destroy
    @supply.destroy
    respond_to do |format|
      format.html { redirect_to supplies_url, notice: "Supply was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supply
      @supply = Supply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supply_params
      params.require(:supply).permit(:supplier_id, :purchase_total, :estimated_total, :date_ordered, :date_expected, :date_received, :supply_product_id)
    end

    def sort_column
      params[:sort] || "created_at"
     end
     
     def sort_direction
       params[:direction] || "asc"
     end        
     
end


