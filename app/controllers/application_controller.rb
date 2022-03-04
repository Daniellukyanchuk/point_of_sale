class ApplicationController < ActionController::Base
	# before_filter :set_gettext_textdomain
	before_action :set_gettext_locale

	# Reloads the translations in development. Production should  be done in the initializer

	def set_gettext_textdomain
		FastGettext.reload! if Rails.env.development?
	end 
end
