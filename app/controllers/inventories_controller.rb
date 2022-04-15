class InventoriesController < ApplicationController
  before_action :set_inventory, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  # GET /inventories or /inventories.json
  def index
    params[:start_date] = 1.month.ago.strftime("%d-%m-%Y") if params[:start_date].blank?
    
    params[:end_date] = Date.today.strftime("%d-%m-%Y") if params[:end_date].blank?

    @inventories = Inventory.search(params[:search], params[:product_select], params[:start_date], params[:end_date])
                   .order(sort_column + " " + sort_direction)      
  end

  # GET /inventories/1 or /inventories/1.json
  def show
  end

  # GET /inventories/new
  def new
    @inventory = Inventory.new
  end

  # GET /inventories/1/edit
  def edit
  end
  
  def get_product_amount_info
    
    # ActiveRecord::Base.connection.execute("select product_id, sum(current_amount_left) from inventories where product_id = #{params[:id].to_i}
    #                                        group by product_id")

    inventory_product_amount = Inventory.where(product_id: params[:id]).sum(&:current_amount_left) 
   
    render json: {current_amount_left: inventory_product_amount }
  end

  # POST /inventories or /inventories.json
  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to @inventory, notice: "Inventory was successfully created." }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventories/1 or /inventories/1.json
  def update
    respond_to do |format|
      if @inventory.update(inventory_params)
        format.html { redirect_to @inventory, notice: "Inventory was successfully updated." }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1 or /inventories/1.json
  def destroy
    @inventory.destroy
    respond_to do |format|
      format.html { redirect_to inventories_url, notice: "Inventory was successfully destroyed." }
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

    def sort_column
      if params[:sort].blank?
        "product_id"
      else
        params[:sort]
      end
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory
      @inventory = Inventory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def inventory_params
      params.require(:inventory).permit(:product_id, :date, :amount, :price_per_unit, :costs, :current_amount_left, :purchase_product_id, :value_of_item)
    end
end
