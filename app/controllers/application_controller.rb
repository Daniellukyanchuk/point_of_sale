class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :set_gettext_locale
  around_action :switch_locale
  before_action :authenticate_user!
  skip_authorization_check 

	rescue_from CanCan::AccessDenied do |exception|
		# flash["success"] = exception.message    
		# flash["info"] = exception.message    
		# flash["warning"] = exception.message        
		flash['danger'] = _("You don't have permission to do that")
			redirect_back(fallback_location: 'Products')
		# redirect_to url_for :controller => params["controller"]
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

end
