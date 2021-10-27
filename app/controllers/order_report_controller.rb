class OrderReportController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  

  def client_report
     if params[:sort].blank?
        params[:sort] = "client_id"
     else
       params[:sort]
     end

     @client_report = Order.client_report(params[:sort])
  end

  def product_report

    # column_names = ["product_name", "amount_sold", "price", "amount_made", "avg(sale_price)"]

    if params[:sort].blank?
       params[:sort] = "product_name"
    else
      params[:sort]
    end

    if params[:direction] == "desc"
       
    else
      params[:direction] = "desc"
    end

    # col_name = params[:sort] if params[:sort] 
     @product_report = Order.product_report(params[:sort])
  end
  
  private

  def sort_column

    params[:sort]
  end

  def sort_direction
  
   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
