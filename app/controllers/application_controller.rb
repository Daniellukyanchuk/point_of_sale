class ApplicationController < ActionController::Base
	before_action :set_gettext_textdomain
	before_action :set_gettext_locale
	before_action :get_exchange_rate
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
	before_action :authenticate_user!
	 
	# load_and_authorize_resource

	def load_and_authorize
	end

	def default_url_options
		{ locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
	end

	# Reloads the translations in development. Production should  be done in the initializer

	def set_gettext_textdomain
		FastGettext.reload! if Rails.env.development?
	end 

	def get_exchange_rate	
		currency_rates = %x{ curl -X GET -H "Content-Type: application/json" https://www.nbkr.kg/XML/daily.xml }
		currency_json = Hash.from_xml(currency_rates).to_json
		currency_hash = JSON.parse(currency_json)

        currency_usd = currency_hash["CurrencyRates"]["Currency"][0]["Value"]
        currency_eur = currency_hash["CurrencyRates"]["Currency"][1]["Value"]

		@exchange_rate_usd = currency_usd.gsub(/[.,]/, '.' => '', ',' => '.').to_f
		@exchange_rate_eur = currency_eur.gsub(/[.,]/, '.' => '', ',' => '.').to_f
	end


	protected
	    rescue_from CanCan::AccessDenied do |exception|       
		    flash['danger'] = _("You are not authorized to do this action")
		    redirect_to action: :index
		end

		def configure_permitted_parameters
		  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
		    user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
		  end
		end
end
