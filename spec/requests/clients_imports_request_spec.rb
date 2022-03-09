require 'rails_helper'

RSpec.describe "ClientsImports", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/clients_imports/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/clients_imports/create"
      expect(response).to have_http_status(:success)
    end
  end

end
