require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー登録" do

    context "新規登録できる時" do

      it "入力内容が正しければ新規登録できる" do
         expect(@user).to be_valid
      end

    end
  end
end
