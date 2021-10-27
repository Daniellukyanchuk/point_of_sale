class ReportsController < ApplicationController
    

    def product_report
        @product_reports = Order.product_report()
    end

    def client_report
        @client_reports = Order.client_report()
    end

end
