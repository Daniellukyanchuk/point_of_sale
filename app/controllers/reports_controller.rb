class ReportsController < ApplicationController
    

    def product_report
        if params[:from_date].blank?
            params[:from_date] = (Date.today-60).strftime('%m/%d/%Y')
        end
        if params[:to_date].blank?
            params[:to_date] = Date.today.strftime('%m/%d/%Y')
        end

        @product_reports = Order.product_report(params[:search], params[:product_select], params[:sort], 
        params[:direction], params[:from_date], params[:to_date])

    end

    def client_report
        @client_reports = Order.client_report(params[:search], params[:client_select], params[:sort], 
        params[:direction], params[:from_date], params[:to_date])
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

    def pick_client
        params[:client_select]
    end

    def pick_product
        params[:product_select]
    end
            
end

