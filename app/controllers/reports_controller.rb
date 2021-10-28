class ReportsController < ApplicationController
    

    def product_report
        @product_reports = Order.product_report(params[:search], params[:sort], params[:direction])
    end

    def client_report
        @client_reports = Order.client_report(params[:search], params[:sort], params[:direction])
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
