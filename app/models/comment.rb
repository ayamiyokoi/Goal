class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  has_many :notifications, dependent: :destroy


  # コメント通知機能
  def create_notification_comment(current_user, review_id, commented_id, comment_id)
    # 自分の投稿に対して自分以外にコメントしている人をすべて取得し、通知を送る


    # reviews_ids.each do |reviews_id|
    #   temp_ids = Comment.select(:user_id).where(review_id: reviews_id).where.not(user_id: current_user.id).distinct
    #   # binding.irb
    #   temp_ids.each do |temp_id|
     save_notification_comment(current_user, review_id, commented_id, comment_id)
        # save_notification_comment(current_user, comment_id, temp_id['user_id'], review_id)
    #   end
    # end
    # # まだ誰もコメントしていない場合は、投稿者に通知を送る
    # save_notification_comment(current_user, comment_id, user_id, review_id) if temp_ids.blank?

  end

   def save_notification_comment(current_user, review_id, visited_id, comment_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      review_id: review_id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分が自分の投稿に対してコメントする場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


end
