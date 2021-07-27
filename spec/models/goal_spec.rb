require 'rails_helper'

RSpec.describe Goal, type: :model do
  before do
    @goal = FactoryBot.build(:goal)
  end

  describe "バリデーションのテスト" do
    it "目標名がなければ無効な状態であること" do
      @goal.name = ""
      @goal.valid?
      expect(@goal.errors[:name]).to include("を入力してください")
    end

    it "日時がなければ無効な状態であること" do
      @goal.date = ""
      @goal.valid?
      expect(@goal.errors[:date]).to include("を入力してください")
    end
  end
end
