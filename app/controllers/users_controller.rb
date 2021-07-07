class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @review = Review.where(user_id: @user.id).limit(1)
  end

  def index
    @users = User.all
  end

end
