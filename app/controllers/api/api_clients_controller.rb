class Api::ApiClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]
  helper_method :sort_column, :sort_direction
  skip_authorization_check
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  

  # GET /clients or /clients.json
  def index
    @clients = Client.all

    render json: @clients
  end

  # GET /clients/1 or /clients/1.json
  def show
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { render json: @client, notice: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    respond_to do |format|

      c = Client.where("id = ?", params[:id]).first
      if c.nil?
        render json: {"error": "No client with ID #{params[:id]}"}
        return
      end

      if @client.update(client_params)
        format.html { render json: @client, notice: "Client was successfully updated." }
        format.json { render :show, status: :ok, location: @client }
      else
        render json: {"error": "No client with id: #{params[:id]}"}
        return 
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def sort_column
      Client.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:id, :name, :phone, :address, :city, :country)
    end
end