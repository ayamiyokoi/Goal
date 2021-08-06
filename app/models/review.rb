# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :rate, :presence => { :message => "を入力してください" }, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100, :message => "を0～100で入力してください" }
  validates :review, :presence => { :message => "を入力してください" }
  validates :plan, :presence => { :message => "を入力してください" }
  validates :title, :presence => { :message => "を入力してください" }
  validates :topic, :presence => { :message => "を入力してください" }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def written_by?(current_user)
    user == current_user
  end

  def self.sorted_by_likes
    Review.includes(:liked_users).sort { |a, b| b.liked_users.size <=> a.liked_users.size }
  end

  def liked_users_count
    likes.count
  end

  def self.review_point(current_user)
    Review.where(user_id: current_user.id).count
  end

  # 友達の公開中のReview
  def self.active_friend_review(current_user)
    # 公開ステータス１か２で、公開中のReview
    Review.where(user_id: current_user.friends.where(show_status: 1).or(current_user.friends.where(show_status: 2)).pluck(:id), active: true)
  end

  # 公開中のすべてのReview
  def self.active_all_review
    Review.where(user_id: User.where(show_status: 2).pluck(:id), active: true)
  end

  # いいね通知機能
  def create_notification_like(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ", current_user.id, user_id, id, "like"])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: "like"
      )
      # 自分が自分の投稿に対していいねする場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
