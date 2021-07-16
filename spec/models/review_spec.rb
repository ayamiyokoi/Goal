require 'rails_helper'

RSpec.describe Review, type: :model do


  before do
    @review = FactoryBot.build(:review)
  end


   describe "バリデーションのテスト" do

    it "達成率がなければ無効な状態であること" do
      @review.rate = ""
      @review.valid?
      expect(@review.errors[:rate]).to include("を入力してください")
    end
    
    it "振り返りがなければ無効な状態であること" do
      @review.review = ""
      @review.valid?
      expect(@review.errors[:review]).to include("を入力してください")
    end
    
    it "予定がなければ無効な状態であること" do
      @review.plan = ""
      @review.valid?
      expect(@review.errors[:plan]).to include("を入力してください")
    end
    
    it "タイトルがなければ無効な状態であること" do
      @review.title = ""
      @review.valid?
      expect(@review.errors[:title]).to include("を入力してください")
    end
    
    it "トピックがなければ無効な状態であること" do
      @review.topic = ""
      @review.valid?
      expect(@review.errors[:topic]).to include("を入力してください")
    end
  end

end