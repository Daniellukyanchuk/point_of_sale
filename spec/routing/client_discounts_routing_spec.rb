require "rails_helper"

RSpec.describe ClientDiscountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/client_discounts").to route_to("client_discounts#index")
    end

    it "routes to #new" do
      expect(get: "/client_discounts/new").to route_to("client_discounts#new")
    end

    it "routes to #show" do
      expect(get: "/client_discounts/1").to route_to("client_discounts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/client_discounts/1/edit").to route_to("client_discounts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/client_discounts").to route_to("client_discounts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/client_discounts/1").to route_to("client_discounts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/client_discounts/1").to route_to("client_discounts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/client_discounts/1").to route_to("client_discounts#destroy", id: "1")
    end
  end
end
