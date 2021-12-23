class InventoryRecordsController < ApplicationController
  before_action :set_inventory_record, only: %i[ show edit update destroy ]

  # GET /inventory_records or /inventory_records.json
  def index
    @inventory_records = InventoryRecord.all
  end

  # GET /inventory_records/1 or /inventory_records/1.json
  def show
  end

  # GET /inventory_records/new
  def new
    @inventory_record = InventoryRecord.new
  end

  # GET /inventory_records/1/edit
  def edit
  end

  # POST /inventory_records or /inventory_records.json
  def create
    @inventory_record = InventoryRecord.new(inventory_record_params)

    respond_to do |format|
      if @inventory_record.save
        format.html { redirect_to @inventory_record, notice: "Inventory record was successfully created." }
        format.json { render :show, status: :created, location: @inventory_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_records/1 or /inventory_records/1.json
  def update
    respond_to do |format|
      if @inventory_record.update(inventory_record_params)
        format.html { redirect_to @inventory_record, notice: "Inventory record was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_records/1 or /inventory_records/1.json
  def destroy
    @inventory_record.destroy
    respond_to do |format|
      format.html { redirect_to inventory_records_url, notice: "Inventory record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_record
      @inventory_record = InventoryRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inventory_record_params
      params.require(:inventory_record).permit(:product_id, :supply_id, :purchase_quantity, :remaining_quantity,
        suppliers_attributes: [:supplier_name], 
        products_attributes: [:product_name], 
        supply_products_attributes: [:id, :purchase_price, :purchase_subtotal, :purchase_quantity, :product_id, :supply_id])
    end
end

