class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @review = Review.where(user_id: @user.id).first
    # from  = Time.current.at_beginning_of_day
    # to    = (from - 6.day).at_end_of_day
    @data = Review.where(user_id: @user.id).pluck(:created_at, :rate)
    @to = Time.current.at_beginning_of_day
    @from = (@to - 6.day).at_end_of_day
    unless @review == nil
      @rate = {"達成" => @review.rate, "未達成" => 100-@review.rate}
    end
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

end
