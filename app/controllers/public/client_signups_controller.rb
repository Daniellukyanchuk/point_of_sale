class Public::ClientSignupsController < ApplicationController
  
  def new
    @client_signup = ClientSignup.new
  end

  def create
    @client_signup = ClientSignup.new(params[:client_signup])
    if @client_signup.save
      redirect_to client_signups_path
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_client_signup
    @client_signup = ClientSignup.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_signup_params
    params = ClientSignup.compile_date(@_params) 
    params.require(:client_signup).permit(:name, :last_name, :middle_name, :email, :phone, :address, :city, :zip_code, :gender, :dob_day, :dob_month, :dob_year, :date_of_birth, :contact_method)
  end

end