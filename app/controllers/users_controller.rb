# frozen_string_literal: true

class UsersController < ApplicationController
  LIMIT_PER_PAGE_3 = 3
  LIMIT_PER_PAGE_10 = 10

  def show
    @goals = Goal.where(user_id: params[:id]).where(achieved: false).order(date: "ASC").page(params[:page]).per(LIMIT_PER_PAGE_3)
    @tasks = Task.where(user_id: params[:id]).where(finished: false).order(date: "ASC").page(params[:page]).per(LIMIT_PER_PAGE_3)
    @user = User.find(params[:id])
    @review = Review.where(user_id: @user.id).last
    @to = Time.current.at_end_of_day + (7 * params[:week_id].to_i).day
    @from = (@to - 6.day).at_beginning_of_day
    @data = Review.where(user_id: @user.id).where(created_at: @from..@to).pluck(:created_at, :rate).map do |d|
      [d.first.beginning_of_day, d.second]
    end
    unless @review.nil?
      # %表示
      @rate = { "達成" => @review.rate, "未達成" => 100 - @review.rate }
    end
  end

  def index
    @users_know = User.where(id: current_user.friends.pluck(:friend_id)).page(params[:page]).per(LIMIT_PER_PAGE_10)
    @users = User.where(show_status: 2).page(params[:page]).per(LIMIT_PER_PAGE_10)
    @user = User.new
  end

  def mypage
    @user = User.find(current_user.id)
  end

  def friend_search
    @user = User.find_by(custom_id: params[:keyword])
    @keyword = params[:keyword]
  end
end
