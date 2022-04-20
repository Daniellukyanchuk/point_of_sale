class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_gettext_locale
  around_action :switch_locale
  before_action :authenticate_user!

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

end
