require 'rails_helper'

RSpec.describe "FridgeItems", type: :request do
  describe "post /fridge_items" do
    it "非ログインでは冷蔵庫に食材登録できない" do
      post fridge_items_path
      expect(response).to have_http_status(200)
    end
  end
end
