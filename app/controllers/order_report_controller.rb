class OrderReportController < ApplicationController
  
  def client_report
     @client_report = Order.client_report()
  end

  def product_report
     @product_report = Order.product_report()
  end
  
end
