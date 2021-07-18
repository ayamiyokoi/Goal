# frozen_string_literal: true

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @review = Review.where(user_id: @user.id).first
    @to = Time.current.at_end_of_day + (7 * params[:week_id].to_i).day
    @from = (@to - 6.day).at_beginning_of_day
    @data = Review.where(user_id: @user.id).where(created_at: @from..@to).pluck(:created_at, :rate).map do |d|
      [d.first.beginning_of_day, d.second]
    end
    unless @review == nil
      @rate = {"達成" => @review.rate, "未達成" => 100-@review.rate}
    end
  end

  def index
    @users = User.where(show_status: 2).page(params[:page]).per(10)
    if params[:keyword] == nil
      @user = User.new
    else
      @user = User.search(params[:keyword])
    end
    @users_know = current_user.friends.page(params[:page]).per(10)
  end

  def mypage
    @user = User.find(current_user.id)
  end

  def friend_search
    @user = User.search(params[:keyword])
    render "index"
  end
end

