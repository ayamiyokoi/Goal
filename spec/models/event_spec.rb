require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe "バリデーションのテスト" do
    it "タイトルがなければ無効な状態であること" do
      @event.title = ""
      @event.valid?
      expect(@event.errors[:title]).to include("を入力してください")
    end

    it "開始日時がなければ無効な状態であること" do
      @event.start_time = ""
      @event.valid?
      expect(@event.errors[:start_time]).to include("を入力してください")
    end

    it "終了日時がなければ無効な状態であること" do
      @event.end_time = ""
      @event.valid?
      expect(@event.errors[:end_time]).to include("を入力してください")
    end
  end
end
