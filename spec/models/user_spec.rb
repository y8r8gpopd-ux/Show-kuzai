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

      it "登録時の管理者権限(admin)はfalseである" do
        user = User.create!(email: "test@example.com",password: "password")
        expect(user.reload.admin).to be false
      end

    end

    context "新規登録できない時" do

       it "メールアドレスが入力されていない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "メールアドレスに@を含まない場合登録できない" do
        @user.email = "test123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "すでに登録されているメールアドレスでは登録できない" do
        another_user = FactoryBot.create(:user)
        @user.email = another_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end

      it "パスワードが入力されていない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "パスワードが6文字以上でなければ登録できない" do
        @user.password = "a1234"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "パスワードが128文字以下でなければ登録できない" do
        @user.password = "a" * 129
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it "パスワードは英数字以外使用できない" do
        @user.password = "テストテスト"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end

      it "パスワードの再入力が不一致では登録できない" do
        @user.password_confirmation = "test111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

    end
  end
end
