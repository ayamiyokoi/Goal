# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :set_goal, only: %i[ edit update destroy ]


  def index
     # 自分の目標のみ表示、達成済、未達成で判別
    @goals_active = Goal.where(user_id: current_user.id, achieved: false).page(params[:page]).per(5)
    @goals_done = Goal.where(user_id: current_user.id, achieved: true).page(params[:page]).per(10)
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      #目標設定の個数が２のべき乗ごとにステージが上がる設定
      #自分の目標の数が２の自分のステージ乗であるなら
      if Goal.where(user_id: current_user.id).count == 2**current_user.stage
        #今のステージから1上がる
        current_user.stage = current_user.stage + 1
        byebug
        current_user.update(user_params)
      end
      redirect_to request.referer
    else
      redirect_to "/"
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to goals_path
    else
      redirect_to "/"
    end
  end

  def destroy
    @group.destroy
    redirect_to goals_path
  end


  private
  def set_goal
      @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :date, :achieved)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :level)
  end
end
