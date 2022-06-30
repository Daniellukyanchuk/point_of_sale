 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/client_discounts", type: :request do
  
  # ClientDiscount. As you add validations to ClientDiscount, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      ClientDiscount.create! valid_attributes
      get client_discounts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      client_discount = ClientDiscount.create! valid_attributes
      get client_discount_url(client_discount)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_client_discount_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      client_discount = ClientDiscount.create! valid_attributes
      get edit_client_discount_url(client_discount)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ClientDiscount" do
        expect {
          post client_discounts_url, params: { client_discount: valid_attributes }
        }.to change(ClientDiscount, :count).by(1)
      end

      it "redirects to the created client_discount" do
        post client_discounts_url, params: { client_discount: valid_attributes }
        expect(response).to redirect_to(client_discount_url(ClientDiscount.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ClientDiscount" do
        expect {
          post client_discounts_url, params: { client_discount: invalid_attributes }
        }.to change(ClientDiscount, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post client_discounts_url, params: { client_discount: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested client_discount" do
        client_discount = ClientDiscount.create! valid_attributes
        patch client_discount_url(client_discount), params: { client_discount: new_attributes }
        client_discount.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the client_discount" do
        client_discount = ClientDiscount.create! valid_attributes
        patch client_discount_url(client_discount), params: { client_discount: new_attributes }
        client_discount.reload
        expect(response).to redirect_to(client_discount_url(client_discount))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        client_discount = ClientDiscount.create! valid_attributes
        patch client_discount_url(client_discount), params: { client_discount: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested client_discount" do
      client_discount = ClientDiscount.create! valid_attributes
      expect {
        delete client_discount_url(client_discount)
      }.to change(ClientDiscount, :count).by(-1)
    end

    it "redirects to the client_discounts list" do
      client_discount = ClientDiscount.create! valid_attributes
      delete client_discount_url(client_discount)
      expect(response).to redirect_to(client_discounts_url)
    end
  end
end
