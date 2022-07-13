class OrdersController < ApplicationController
  # before_action :set_order, only: %i[ show edit update destroy ]
  load_and_authorize_resource  
  helper_method :sort_column, :sort_direction  
    
  # GET /orders or /orders.json
  def autofill_price
    @price = Product.where("id = ?", params[:id]).take
  end
  
  def index
    @orders = Order.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    find_finished_products
    @order = Order.new
    @order.order_products.new
    @order.build_client
  end

  # GET /orders/1/edit
  def edit
    find_finished_products
  end

  # POST /orders or /orders.json
  def create
    find_finished_products
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to orders_path, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    put_discount_back
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def put_discount_back
    OrderProduct.where(order_id: params[:id]).each do |rd|
      OrderProduct.return_discount(rd)
    end
  end

  def order_receipt
    render layout: 'plain'
  end
  
  def bulk_receipts 
    @receipts = Order.find(params["order_ids"].map(&:to_i))    

    render layout: 'plain'
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def find_finished_products
      finished_products = CategoryProduct.where("product_category_id = ? or product_category_id = ?", 1,3)
      product_ids = []
      finished_products.each do |finished_product|
        product_ids.push(finished_product.product_id)
      end
      @finished_products = Product.find(product_ids).sort_by &:product_name
    end

    # Only allow a list of trusted parameters through.
    def order_params
      # params["order"]
      if params["order"]["client_id"] == "-1"
        params["order"]["client_id"] = nil
      end 

      if !params["order"]["client_id"].blank?
        params[:order].delete :client_attributes        
      end     

       params.require(:order).permit(:client_id, :grand_total, :order_discount,
       client_attributes: [:id, :name, :address, :phone, :city],
       order_products_attributes: [:id, :product_id, :order_id, :sale_price, :quantity, :subtotal, :item_discount, :_destroy, 
        order_product_discounts_attributes: [:order_product_id, :client_discount_id, :discounted_qt]], 
       products_attributes: [:id, :unit, :price, :product_name])
    end

    def sort_column
     params[:sort] || "created_at"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end    
end



