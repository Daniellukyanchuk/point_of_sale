class SuppliesController < ApplicationController
  before_action :set_supply, only: %i[ show edit update destroy ]


  def get_product_name
    @product_name = Supply.where("id = ?", params[supply_products_attributes.id]).first.product_name
    render json: {price: @price}
  end

  def get_qt
    @qt = Supply.where("id = ?", params[:supply_product_id]).first.quantity
    render json: {qt: @qt}
  end

  def get_supplier
    @supplier = Supply.where("id = ?", params[:product_id]).first.supplier
    render json: {supplier: @supplier}
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
      params.require(:supply).permit(:supplier_id, :purchase_total, :estimated_total, :date_ordered, :date_expected, :date_received,
      suppliers_attributes: [:id, :supplier_name, :address, :phone],
      supply_products_attributes: [:id, :product_id, :supply_id, :estimated_cost, :estimated_quantity, :estimated_subtotal, :purchase_price, :purchase_quantity, :purchase_subtotal, :_destroy],
      products_attributes: [:id, :unit, :price, :product_name])
    end

    def sort_column
      params[:sort] || "created_at"
     end
     
     def sort_direction
       params[:direction] || "asc"
     end        
     
end


