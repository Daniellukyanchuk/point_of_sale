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
        # Getting exchange currency (curl)
		currency_rates = URI.parse('https://www.nbkr.kg/XML/daily.xml').read
		currency_json = Hash.from_xml(currency_rates).to_json
		currency_hash = JSON.parse(currency_json)

        currency_usd = currency_hash["CurrencyRates"]["Currency"][0]["Value"]
        currency_eur = currency_hash["CurrencyRates"]["Currency"][1]["Value"]

		@exchange_rate_usd = currency_usd.gsub(/[.,]/, '.' => '', ',' => '.').to_f
		@exchange_rate_eur = currency_eur.gsub(/[.,]/, '.' => '', ',' => '.').to_f
	end

	def curl_commands
		# Getting a all clients (curl)
		require 'net/http'
		require 'uri'

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
		require 'net/http'
		require 'uri'

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
		require 'net/http'
		require 'uri'
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
		    redirect_to action: :index
		end

		def configure_permitted_parameters
		  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
		    user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
		  end
		end
end
