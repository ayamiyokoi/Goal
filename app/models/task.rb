# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user

  validates :name, :presence => { :message => "を入力してください" }
  validates :body, :presence => { :message => "を入力してください" }
  validates :date, :presence => { :message => "を入力してください" }

  def self.task_point(current_user)
    2 * Task.where(user_id: current_user.id, finished: true).count
  end
  # def self.level_up?(current_user)
  # #目標設達成、タスク処理、振り返りの個数が３３のべき乗ごとにステージが上がる設定
  #     #合計数が３の自分のレベル乗より大きいなら
  #   5*Goal.where(user_id: current_user.id, achieved: true).count + 2*Task.where(user_id: current_user.id, finished: true).count + Review(user_id: current_user.id).count > 3**current_user.level
  # end
end
