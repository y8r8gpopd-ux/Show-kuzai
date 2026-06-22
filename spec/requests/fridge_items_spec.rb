require 'rails_helper'

RSpec.describe "FridgeItems", type: :request do
  describe "post /fridge_items" do
    it "非ログインでは冷蔵庫に食材登録できない" do
      post fridge_items_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
