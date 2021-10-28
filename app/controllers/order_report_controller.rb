class OrderReportController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def client_report
     @client_report = Order.client_report(params[:search], params[:sort], params[:direction])
  end

  def product_report
     @product_report = Order.product_report(params[:search], params[:sort], params[:direction])
  end
  
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
end
