class ReportsController < ApplicationController
    

    def product_report
        @product_reports = Order.product_report(params[:sort])
    end

    def client_report
        @client_reports = Order.client_report(params[:sort])
    end

    private

    def sort_column
        params[:sort] || "id"
    end
       
    def sort_direction
        params[:direction] || "asc"
    end

end
