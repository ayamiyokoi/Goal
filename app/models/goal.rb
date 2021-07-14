# frozen_string_literal: true

class Goal < ApplicationRecord
  belongs_to :user
  validates :name, :presence => {:message => "を入力してください"}
  validates :date, :presence => {:message => "を入力してください"}

  def self.stage_up?(current_user)
   #目標設定の個数が２のべき乗ごとにステージが上がる設定
      #自分の目標の数が２の自分のステージ乗より大きいなら
    Goal.where(user_id: current_user.id).count > 2**current_user.stage
  end

end
