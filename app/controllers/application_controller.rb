class ApplicationController < ActionController::Base
	before_action :set_gettext_textdomain
	before_action :set_gettext_locale
	def default_url_options
		{ locale: ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
	end

	# Reloads the translations in development. Production should  be done in the initializer

	def set_gettext_textdomain
		FastGettext.reload! if Rails.env.development?
	end 
end
