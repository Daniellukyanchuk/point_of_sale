class ReportsController < ApplicationController

    def index
        @product_reports = Order.product_report()
    end

    def index
        @client_reports = Order.client_report()
    end

end
