require 'rails_helper'

RSpec.describe "FridgeItems", type: :request do

  describe "get /ManageFridgeItems" do

    context "ログインしていないとき" do

      it "ログイン画面にリダイレクトされる" do 
        get  manage_fridge_items_path 
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインしてる時" do

      let(:user) { create(:user) }

      before do 
        sign_in user
      end

      it "冷蔵庫を開ける" do 
        get manage_fridge_items_path
        expect(response).to have_http_status(:ok)
      end

    end
  end


  describe "post /fridge_items" do
    it "非ログインでは冷蔵庫に食材登録できない" do
      post fridge_items_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  

end
