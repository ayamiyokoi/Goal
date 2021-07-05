class CommentsController < ApplicationController
  before_action :set_review, only: %i[ create destroy ]

  def create
    @comment = @review.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.review_id = @review.id
    @comment.save
    # redirect_to review_path(review)
  end

  def update
  end

  def destroy
    Comment.find_by(id: params[:id], review_id: params[:review_id]).destroy
    # redirect_to review_path(params[:review_id])
  end

  private
  def set_review
       @review = Review.find(params[:review_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
