class FollowsController < ApplicationController
  def show
    user = User.find(params[:user_id])
    @users_followings = user.followings
    @users_followers = user.followers
  end

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end



end
