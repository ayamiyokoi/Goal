# frozen_string_literal: true

class GoalsController < ApplicationController
  before_action :set_goal, only: %i(edit update destroy)
  LIMIT_PER_PAGE = 5

  def index
    # 自分の目標のみ表示、達成済、未達成で判別
    @goals_active = Goal.where(user_id: current_user.id, achieved: false).order(date: "ASC").page(params[:page]).per(LIMIT_PER_PAGE)
    @goals_done = Goal.where(user_id: current_user.id, achieved: true).order(date: "DESC").page(params[:page]).per(LIMIT_PER_PAGE)
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      if Goal.stage_up?(current_user)
        # 今のステージから1上がる
        current_user.upgrade_stage
        flash[:notice] = "ステージ「＋１」アップ 、現在のステージは#{current_user.stage}です。"
      end
      redirect_to request.referer
    else
      render "index"
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      # 目標達成で5pt, タスク達成で2pt, 振り返り投稿で1pt、自分のレベルの3乗倍のポイントがたまるとレベルアップ
      if Goal.goal_point(current_user) + Task.task_point(current_user) + Review.review_point(current_user) > 3**current_user.level
        # レベル+1
        current_user.upgrade_level
        flash[:notice] = "レベル「＋１」アップ 、現在のレベルは#{current_user.level}です。"
      end
      redirect_to goals_path
    else
      render "index"
    end
  end

  def destroy
    @goal.destroy
    redirect_to goals_path
    flash[:notice] = "目標を削除しました。"
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :date, :achieved)
  end
end
