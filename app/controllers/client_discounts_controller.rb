class ClientDiscountsController < ApplicationController
  before_action :set_client_discount, only: %i[ show edit update destroy ]

  # GET /client_discounts or /client_discounts.json
  def index
    @client_discounts = ClientDiscount.all
  end

  # GET /client_discounts/1 or /client_discounts/1.json
  def show
  end

  # GET /client_discounts/new
  def new
    @client_discount = ClientDiscount.new
  end

  # GET /client_discounts/1/edit
  def edit
  end

  # POST /client_discounts or /client_discounts.json
  def create
    parse_dates
    @client_discount = ClientDiscount.new(client_discount_params)

    respond_to do |format|
      if @client_discount.save
        format.html { redirect_to client_discount_url(@client_discount), notice: "Client discount was successfully created." }
        format.json { render :show, status: :created, location: @client_discount }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_discounts/1 or /client_discounts/1.json
  def update
    respond_to do |format|
      if @client_discount.update(client_discount_params)
        format.html { redirect_to client_discount_url(@client_discount), notice: "Client discount was successfully updated." }
        format.json { render :show, status: :ok, location: @client_discount }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client_discount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_discounts/1 or /client_discounts/1.json
  def destroy
    @client_discount.destroy

    respond_to do |format|
      format.html { redirect_to client_discounts_url, notice: "Client discount was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def parse_dates     
      params["client_discount"]["start_date"] = "#{Date.strptime((params["client_discount"]["start_date"]).to_s, '%m/%d/%Y')}"      
      params["client_discount"]["end_date"] = "#{Date.strptime((params["client_discount"]["end_date"]).to_s, '%m/%d/%Y')}"     
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_client_discount
      @client_discount = ClientDiscount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_discount_params
      params.require(:client_discount).permit(:discount_name, :client_id, :discount_per_unit, :discounted_units, :discounted_units_left, :start_date, :end_date)
    end
end
