class ClientsImportsController < ApplicationController
  def new
    @clients_import = ClientsImport.new
  end

  def create
    @clients_import = ClientsImport.new(params[:clients_import])
    if @clients_import.save 
      redirect_to clients_path 
    else
      render :new 
    end 
  end
end
