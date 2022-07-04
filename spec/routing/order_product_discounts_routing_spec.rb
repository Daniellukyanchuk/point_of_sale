require "rails_helper"

RSpec.describe OrderProductDiscountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/order_product_discounts").to route_to("order_product_discounts#index")
    end

    it "routes to #new" do
      expect(get: "/order_product_discounts/new").to route_to("order_product_discounts#new")
    end

    it "routes to #show" do
      expect(get: "/order_product_discounts/1").to route_to("order_product_discounts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/order_product_discounts/1/edit").to route_to("order_product_discounts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/order_product_discounts").to route_to("order_product_discounts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/order_product_discounts/1").to route_to("order_product_discounts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/order_product_discounts/1").to route_to("order_product_discounts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/order_product_discounts/1").to route_to("order_product_discounts#destroy", id: "1")
    end
  end
end
