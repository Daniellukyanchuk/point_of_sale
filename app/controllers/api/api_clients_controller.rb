class Api::ApiClientsController < ApplicationController
  # before_action :set_client, only: %i[ show edit update destroy ]
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

  # GET /clients/new
  
  # GET /clients/1/edit  

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { render json: @client, success: "Client was successfully created." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    c = Client.where("id = ?", params[:id]).first
      if c.nil?
        render json: {"error": "No client with ID #{params[:id]}"}
        return
      end
    c.assign_attributes(client_params)
    if c.save
      render json: c, success: "Client was successfully updated!"
    else
      render json: {"error": c.errors.messages.values.join(', ')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:id, :name, :phone, :address, :city)
    end

    def sort_column
      params[:sort] || "created_at"
    end
    
    def sort_direction
      params[:direction] || "asc"
    end        

end
