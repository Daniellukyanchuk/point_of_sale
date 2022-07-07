class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource :except => [:processing_payment]
  skip_before_action :authenticate_user!, :only => [:processing_payment]

  # GET /orders or /orders.json
  def index
    params[:start_date] = 1.month.ago.strftime("%d-%m-%Y") if params[:start_date].blank?
    params[:end_date] = Date.today.strftime("%d-%m-%Y") if params[:end_date].blank?
    @orders = Order.search(params[:search], params[:client_select], params[:start_date], params[:end_date])
              .order(sort_column + " " + sort_direction)
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    ab = Ability.new(current_user)

    if !(can? :write, Order)
      flash[:danger] = "You are not authorized"
      redirect_to action: :index
    end

    @order = Order.new
    @order.order_products.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
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
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def order_invoice 
    @order_invoice = Order.find(params[:id])
    render layout: "invoice"
  end

  def bulk_invoice
    @order_bulk_invoices = Order.find(params[:order_ids])
    render layout: "invoice"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      if params[:sort].blank?
        "client_id"
      else
        params[:sort]
      end
      # Order.column_names.include?(params[:sort]) ? params[:sort] : "client_id"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
        if params[:order][:client_id] == "-1"
         params[:order][:client_id] = nil 
        end

        params.require(:order).permit(:client_id, :name, :phone, :address, :city, :country, :cover_picture, :grand_total, :order_discount, order_products_attributes: [:id, :product_id, :order_id, :sale_price, :quantity, :subtotal, :discount, :percentage_of_total, :discount_to_apply, :discount_per_unit, :_destroy] )    
    end

    def start_date
      params[:start_date]
    end

    def end_date
      params[:end_date]
    end
end
