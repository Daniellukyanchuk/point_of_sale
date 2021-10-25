class ReportsController < ApplicationController

    def index
        @product_reports = Order.products_report()
    end

    def index
        @clients_reports = Order.clients_report()
    end

end
