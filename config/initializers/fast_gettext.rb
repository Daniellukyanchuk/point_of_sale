require 'fast_gettext'
FastGettext.add_text_domain 'app', :path => 'locale', :type => :po
FastGettext.default_available_locales = ['en','ru'] #all you want to allow
FastGettext.default_text_domain = 'app'
