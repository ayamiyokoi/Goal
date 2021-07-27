# frozen_string_literal: true

class FollowsController < ApplicationController
  LIMIT_PER_PAGE = 10

  def show
    user = User.find(params[:user_id])
    @users_followings = user.followings.page(params[:page]).per(LIMIT_PER_PAGE)
    @users_followers = user.followers.page(params[:page]).per(LIMIT_PER_PAGE)
  end

  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end
