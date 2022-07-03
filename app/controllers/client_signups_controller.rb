class ClientSignupsController < ApplicationController  

  def new
    @client_signup = ClientSignup.new
    render layout: 'public'
  end


  private
  # Use callbacks to share common setup or constraints between actions.


  # Only allow a list of trusted parameters through.
  # def client_signup_params
  #   params = Client.compile_date(@_params)
  #   params.require(:client_signup).permit(:name, :last_name, :middle_name, :email, :phone, :address, :city, :zip_code, :gender, :dob_day, :dob_month, :dob_year, :date_of_birth, :contact_method)
  # end

end