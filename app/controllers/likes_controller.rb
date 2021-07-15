# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_review, only: %i[ create destroy ]

  def create
    @like = current_user.likes.create(review_id: params[:review_id])
    @review.create_notification_like(current_user)
  end

  def destroy
    @like = Like.find_by(review_id: params[:review_id], user_id: current_user.id)
    @like.destroy
  end

  private
  def set_review
    @review = Review.find(params[:review_id])
  end
end
