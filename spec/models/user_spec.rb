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

    context "新規登録できない時" do

       it "メールアドレスが入力されていない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスに@を含まない" do
        @user.email = "test123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end


    end
  end
end
