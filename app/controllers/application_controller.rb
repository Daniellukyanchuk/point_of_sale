require 'net/http'
require 'open-uri'

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_gettext_locale
  before_action :authenticate_user!
  skip_authorization_check 
  add_flash_types :danger, :info, :warning, :success, :messages

	rescue_from CanCan::AccessDenied do |exception|		   
		flash["danger"] = _("You don't have permission to do that")
			redirect_back(fallback_location: inventory_report_path )
	end

	def default_url_options
		{ locale: I18n.locale }
	end

	def set_locale
		I18n.locale = params[:locale] || I18n.default_locale
	end	

	def get_exchange_rate
		res_xml = URI.parse('https://www.nbkr.kg/XML/daily.xml').read
		ex_rate_info_json = Hash.from_xml(res_xml).to_json
		ex_rates = JSON.parse(ex_rate_info_json)
		usd_to_som_rate = ex_rates["CurrencyRates"]["Currency"][0]["Value"].gsub(/,/, ".").to_f
		session[:rate] = usd_to_som_rate
		render json: {rate: session[:rate]}
	end

end
