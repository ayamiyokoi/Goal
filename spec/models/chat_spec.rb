require 'rails_helper'

RSpec.describe Chat, type: :model do
  before do
    @chat = FactoryBot.build(:chat)
  end

  describe "バリデーションのテスト" do
    it "チャットがなければ無効な状態であること" do
      @chat.chat = ""
      @chat.valid?
      expect(@chat.errors[:chat]).to include("を入力してください")
    end
  end
end
