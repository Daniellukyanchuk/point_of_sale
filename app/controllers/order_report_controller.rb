class OrderReportController < ApplicationController
  helper_method :sort_column, :sort_direction

  def client_report
     @client_report = Order.client_report()
  end

  def product_report
     @product_report = Order.product_report(params[:sort])
  end
  
  private

  def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
