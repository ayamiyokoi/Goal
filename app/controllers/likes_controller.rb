class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(review_id: params[:review_id])
  end

  def destroy
    @like = Like.find_by(review_id: params[:review_id], user_id: current_user.id)
    @like.destroy
  end

end
