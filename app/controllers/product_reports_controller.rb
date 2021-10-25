class ProductReportsController < ApplicationController

    def index
        @product_reports = ProductReport.all
      end

end
