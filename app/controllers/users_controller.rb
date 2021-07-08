class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @review = Review.where(user_id: @user.id).first
    # from  = Time.current.at_beginning_of_day
    # to    = (from - 6.day).at_end_of_day
    @data = Review.where(user_id: @user.id).pluck(:created_at, :rate)
  end

  def index
    @users = User.all
  end

end
