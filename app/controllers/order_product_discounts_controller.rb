class OrderProductDiscountsController < ApplicationController
  before_action :set_order_product_discount, only: %i[ show edit update destroy ]

  # GET /order_product_discounts or /order_product_discounts.json
  def index
    @order_product_discounts = OrderProductDiscount.all
  end

  # GET /order_product_discounts/1 or /order_product_discounts/1.json
  def show
  end

  # GET /order_product_discounts/new
  def new
    @order_product_discount = OrderProductDiscount.new
  end

  # GET /order_product_discounts/1/edit
  def edit
  end

  # POST /order_product_discounts or /order_product_discounts.json
  def create
    @order_product_discount = OrderProductDiscount.new(order_product_discount_params)

    respond_to do |format|
      if @order_product_discount.save
        format.html { redirect_to order_product_discount_url(@order_product_discount), notice: "Order product discount was successfully created." }
        format.json { render :show, status: :created, location: @order_product_discount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_product_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_product_discounts/1 or /order_product_discounts/1.json
  def update
    respond_to do |format|
      if @order_product_discount.update(order_product_discount_params)
        format.html { redirect_to order_product_discount_url(@order_product_discount), notice: "Order product discount was successfully updated." }
        format.json { render :show, status: :ok, location: @order_product_discount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_product_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_product_discounts/1 or /order_product_discounts/1.json
  def destroy
    @order_product_discount.destroy

    respond_to do |format|
      format.html { redirect_to order_product_discounts_url, notice: "Order product discount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_product_discount
      @order_product_discount = OrderProductDiscount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_product_discount_params
      params.require(:order_product_discount).permit(:discount_id, :order_product_id, :discount_quantity)
    end
end
