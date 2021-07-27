require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "バリデーションのテスト" do
    it "名前、メール、パスワードがあれば有効な状態であること" do
      expect(@user).to be_valid
    end

    # it "名前がなければ無効な状態であること" do
    #   @user.name = ""
    #   @user.valid?
    #   expect(@user.errors[:name]).to include("を入力してください")
    # end

    it "メールアドレスがなければ無効な状態であること" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスなら無効な状態であること" do
      FactoryBot.create(:user) # 先に保存される
      @user.valid?
      expect(@user.errors[:email]).to include("はすでに存在します")
    end

    it "パスワードが6文字以上でなければ無効であること" do
      @user.password = "a" * 5
      @user.valid?
      expect(@user.errors[:password]).to include("は6文字以上で入力してください")
    end
  end
end
