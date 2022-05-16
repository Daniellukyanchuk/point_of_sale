require 'net/http'
require 'open-uri'

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_gettext_locale
  around_action :switch_locale
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  skip_authorization_check 
  before_action :get_exchange_rate
  add_flash_types :danger, :info, :warning, :success, :messages

	rescue_from CanCan::AccessDenied do |exception|
		# flash["success"] = exception.message    
		# flash["info"] = exception.message    
		# flash["warning"] = exception.message        
		flash["danger"] = _("You don't have permission to do that")
			redirect_back(fallback_location: '/devise/users/sign_in')
	end

	def default_url_options
		{ locale: I18n.locale }
	end

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end	

	def switch_locale(&action)
		locale = params[:locale] || I18n.default_locale
		I18n.with_locale(locale, &action)
	end

	def get_exchange_rate
		res_xml = URI.parse('https://www.nbkr.kg/XML/daily.xml').read
		ex_rate_info_json = Hash.from_xml(res_xml).to_json
		ex_rates = JSON.parse(ex_rate_info_json)
		usd_to_som_rate = ex_rates["CurrencyRates"]["Currency"][0]["Value"].gsub(/,/, ".").to_f
		@exchange_rate = usd_to_som_rate
	end

end
