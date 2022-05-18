class ReportsController < ApplicationController  

    def product_report
        if params[:from_date].blank?
            params[:from_date] = (Date.today-30).strftime('%m/%d/%Y')
        end
        if params[:to_date].blank?
            params[:to_date] = (Date.today+2).strftime('%m/%d/%Y')
        end           

        @product_reports = Order.product_report(params[:search], params[:product_select], params[:from_date], 
        params[:to_date], params[:sort], params[:direction])

        @sales_records = Order.sales_record(params[:search], params[:product_select], params[:from_date], 
        params[:to_date], params[:sort], params[:direction])
    end

    def inventory_report 
      
        if params[:from_date].blank?
            params[:from_date] = (Date.today-360).strftime('%m/%d/%Y')
        end

        if params[:to_date].blank?
            params[:to_date] = (Date.today+2).strftime('%m/%d/%Y')
        end           

        @inventory_summaries = Inventory.inventory_summary(params[:search], params[:product_select], params[:from_date], 
        params[:to_date], params[:sort], params[:direction])  

    end

    def purchase_report
        if params[:from_date].blank?
            params[:from_date] = (Date.today-30).strftime('%m/%d/%Y')
        end

        if params[:to_date].blank?
            params[:to_date] = (Date.today+2).strftime('%m/%d/%Y')
        end           

        @purchase_reports = Purchase.purchase_report(params[:search], params[:product_select], params[:from_date], 
        params[:to_date], params[:sort], params[:direction])

        @purchase_records = Purchase.purchase_record(params[:search], params[:product_select], params[:from_date], 
        params[:to_date], params[:sort], params[:direction])
    end

    def client_report
        if params[:from_date].blank?
            params[:from_date] = (Date.today-30).strftime('%m/%d/%Y')
        end
        if params[:to_date].blank?
            params[:to_date] = (Date.today+2).strftime('%m/%d/%Y')
        end

        @client_reports = Order.client_report(params[:search], params[:client_select], params[:from_date], 
        params[:to_date], params[:sort], params[:direction])
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

