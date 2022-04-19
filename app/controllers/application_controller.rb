class ApplicationController < ActionController::Base
	before_action :set_gettext_textdomain
	before_action :set_gettext_locale
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :authenticate_user!

	def default_url_options
		{ locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
	end

	# Reloads the translations in development. Production should  be done in the initializer

	def set_gettext_textdomain
		FastGettext.reload! if Rails.env.development?
	end 


	protected
		def configure_permitted_parameters
		  devise_parameter_sanitizer.permit(:sign_up) do |user_params|
		    user_params.permit({ roles: [] }, :email, :password, :password_confirmation)
		  end
		end
end
