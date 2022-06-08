class PurchasesController < ApplicationController
  before_action :set_purchase, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource

  # GET /purchases or /purchases.json
  def index
    params[:start_date] = 1.month.ago.strftime("%d-%m-%Y") if params[:start_date].blank?
    params[:end_date] = Date.today.strftime("%d-%m-%Y") if params[:end_date].blank?

    @purchases = Purchase.search(params[:search], params[:supplier_select], params[:start_date], params[:end_date])
                 .order(sort_column + " " + sort_direction)
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

  def get_purchase_product_info
    purchase_id = params[:id]
    @purchase_row = PurchaseProduct.find(purchase_id.to_i) 
    render json: {estimated_quantity: @purchase_row.estimated_quantity, estimated_price_per_unit: @purchase_row.estimated_price_per_unit, product_id: @purchase_row.product_id, estimated_subtotal: @purchase_row.estimated_subtotal }
  end

  # POST /purchases or /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: "Purchase was successfully created." }
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
        format.html { redirect_to @purchase, notice: "Purchase was successfully updated." }
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
      format.html { redirect_to purchases_url, notice: "Purchase was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  
    def start_date
      params[:start_date]
    end

    def end_date
      params[:end_date]
    end
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      Purchase.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def purchase_params    
      if params[:purchase][:supplier_id] == "-1"
        params[:purchase][:supplier_id] = nil
      end
     
      params[:purchase][:purchase_products_attributes].each do |p|
        if p[1][:product_id] == "-1"
          p[1][:product_id] = nil
        end
      end

      params.require(:purchase).permit(:supplier_id, :suppliers_name, :city, :country, :address, :phone_number, :date_of_the_order, :expected_date_of_delivery, :estimated_total, :actual_total, 
      purchase_products_attributes: [:id, :product_id, :purchase_id, :estimated_price_per_unit, :actual_price_per_unit, :estimated_quantity, 
      :actual_quantity, :estimated_subtotal, :actual_subtotal, :product_name, :price, :unit, :categories, :_destroy])
    end
end

