# frozen_string_literal: true

class Goal < ApplicationRecord
  belongs_to :user
  validates :name, :presence => { :message => "を入力してください" }
  validates :date, :presence => { :message => "を入力してください" }

  def self.stage_up?(current_user)
    # 目標設定の個数の3倍ごとにステージが上がる設定
    # 自分の目標の数が自分のステージの3倍より大きいなら
    Goal.where(user_id: current_user.id).count > 3*current_user.stage
  end

  def self.goal_point(current_user)
    5 * Goal.where(user_id: current_user.id, achieved: true).count
  end
end
