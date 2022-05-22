class RolesImportsController < ApplicationController
  
    def new
      @roles_import = RolesImport.new
    end
  
    def create
      @roles_import = RolesImport.new(params[:roles_import])
      if @roles_import.save
        redirect_to roles_path
      else
        render :new
      end
    end
  end
  