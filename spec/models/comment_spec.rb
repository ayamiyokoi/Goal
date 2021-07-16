require 'rails_helper'

RSpec.describe Comment, type: :model do


  before do
    @comment = FactoryBot.build(:comment)
  end


   describe "バリデーションのテスト" do

    it "コメントがなければ無効な状態であること" do
      @comment.comment = ""
      @comment.valid?
      expect(@comment.errors[:comment]).to include("コメントを入力してください")
    end
  end

end