require 'rails_helper'

RSpec.describe Task, type: :model do


  before do
    @task = FactoryBot.build(:task)
  end


   describe "バリデーションのテスト" do

    it "タスク名がなければ無効な状態であること" do
      @task.name = ""
      @task.valid?
      expect(@task.errors[:name]).to include("を入力してください")
    end
    
    it "タスク詳細がなければ無効な状態であること" do
      @task.body = ""
      @task.valid?
      expect(@task.errors[:body]).to include("を入力してください")
    end
    
    it "日時がなければ無効な状態であること" do
      @task.date = ""
      @task.valid?
      expect(@task.errors[:date]).to include("を入力してください")
    end
    
  end

end