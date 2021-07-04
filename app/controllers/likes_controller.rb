class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(review_id: params[:review_id])
    redirect_to request.referer
  end

  def destroy
    @like = Like.find_by(review_id: params[:review_id], user_id: current_user.id)
    @like.destroy
    redirect_to request.referer
  end
end
