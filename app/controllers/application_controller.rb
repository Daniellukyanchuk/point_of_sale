require 'net/http'
require 'open-uri'

class ApplicationController < ActionController::Base
	before_action :set_gettext_textdomain
	before_action :set_gettext_locale
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
	before_action :authenticate_user!

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
        # Getting exchange currency (curl)
        
        if session[:exchange_rate].nil? || session[:exchange_rate] == "null"
			currency_rates = URI.parse('https://www.nbkr.kg/XML/daily.xml').read
			currency_json = Hash.from_xml(currency_rates).to_json
			currency_hash = JSON.parse(currency_json)
	        currency_usd = currency_hash["CurrencyRates"]["Currency"][0]["Value"]
			exchange_rate_usd = currency_usd.gsub(/[.,]/, '.' => '', ',' => '.').to_f	
			session[:exchange_rate] = exchange_rate_usd.to_json
    
			render json: {session_ex_rate: session[:exchange_rate] }
		else
			render json: {session_ex_rate: session[:exchange_rate] }
		end

	end

	def curl_commands
		# Getting a all clients (curl)
		uri = URI.parse("http://localhost:3000/api/clients")
		request = Net::HTTP::Get.new(uri)
		request.content_type = "application/json"

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end
        
        # Creating a client (curl)	
		uri = URI.parse("http://localhost:3000/api/clients")
		request = Net::HTTP::Post.new(uri)
		request.content_type = "application/json"
		request.body = ""
		request.body << File.read("bin/client.json").delete("\r\n")

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end

		# Update client (curl)
		require 'json'

		uri = URI.parse("http://localhost:3000/api/clients/33")
		request = Net::HTTP::Patch.new(uri)
		request.content_type = "application/json"
		request.body = JSON.dump({
		  "client" => {
		    "name" => "Daniel"
		  }
		})

		req_options = {
		  use_ssl: uri.scheme == "https",
		}

		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
		  http.request(request)
		end
	end


	protected
	    rescue_from CanCan::AccessDenied do |exception|       
		    flash['danger'] = _("You are not authorized to do this action")
		    redirect_to client_report_path
		end

		def configure_permitted_parameters
		  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
		    user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
		  end
		end
end
