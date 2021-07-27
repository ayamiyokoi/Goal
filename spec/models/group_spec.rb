require 'rails_helper'

RSpec.describe Group, type: :model do
  before do
    @group = FactoryBot.build(:group)
  end

  describe "バリデーションのテスト" do
    it "名前がなければ無効な状態であること" do
      @group.name = ""
      @group.valid?
      expect(@group.errors[:name]).to include("を入力してください")
    end
  end
end
