class OrderReportController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def client_report
     @client_report = Order.client_report(params[:search], params[:client_select], params[:sort], params[:direction])
  end

  def product_report
   
    params[:start_date] = 1.month.ago.strftime("%d-%m-%Y") if params[:start_date].blank?
    
    params[:end_date] = Date.today.strftime("%d-%m-%Y") if params[:end_date].blank?

    @product_report = Order.product_report(params[:search], params[:product_select], params[:start_date], params[:end_date], params[:sort], params[:direction])
  end

 # I want the default to be in one place, either in the controller or in the view.  
 # If the params[:start_date] is nil, I want it to show the 1.month.ago date, and if not, I want it to be what it is.
  
  private

  def sort_column
    params[:sort]
  end

  def sort_direction  
    params[:direction]
  end

  def search_product
    params[:search]
  end

  def search_client
    params[:search]
  end

  def search_multiple
    params[:client_select]
  end

  def search_multiple
    params[:product_select]
  end

  def start_date
    params[:start_date]
  end

  def end_date
    params[:end_date]
  end
end
