class ClientsController < ApplicationController
  # before_action :set_client, only: %i[ show edit update destroy ]
  load_and_authorize_resource  
  helper_method :sort_column, :sort_direction

  
  # GET /clients or /clients.json
  def index
    @clients = Client.search(params[:search]).order(sort_column + " " + sort_direction)
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to clients_path, success: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def sign_up
    @client = Client.new(client_params)
    
    respond_to do |format|
      if @client.save
        format.html { redirect_to "https://atomy-lifestyle.com/index.php/registration-successful/", success: "Registration was successful." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { redirect_to "https://atomy-system.herokuapp.com/en/client_signups/new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to clients_path, success: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, success: "Client was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    

    # Only allow a list of trusted parameters through.
    def client_params
      params = Client.compile_date(@_params) 
      params.require(:client).permit(:id, :name, :last_name, :middle_name, :email, :phone, :address, :city, :zip_code, :gender, :dob_day, :dob_month, :dob_year, :date_of_birth, :contact_method, :registered)
    end

    def sort_column
      params[:sort] || "created_at"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end        

end
