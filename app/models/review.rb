# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :rate, :presence => {:message => "を入力してください"}
  validates :review, :presence => {:message => "を入力してください"}
  validates :plan, :presence => {:message => "を入力してください"}
  validates :title, :presence => {:message => "を入力してください"}
  validates :topic, :presence => {:message => "を入力してください"}
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def written_by?(current_user)
    user == current_user
  end

  def self.sorted_by_likes
    Review.includes(:liked_users).sort{|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  def liked_users_count
    #liked_users.count
    likes.count
  end

  def self.review_point(current_user)
    Review.where(user_id: current_user.id).count
  end

  #  select reviews.id, reviews.title, count(likes.id), users.id from reviews inner join likes on reviews.id = likes.review_id inner join users on reviews.user_id = users.id where reviews.active = 1 and users.id IN (3, 4)  group by review_id order by count(likes.id) desc ;
  def self.active_friend_review(current_user)
    # Review.includes(:user, :likes).group(:id).where(users: {id: current_user.friends.pluck(:id)}).where(active: true).order("count(likes.id) desc")
    Review.where(user_id: current_user.friends.pluck(:id), active: true)
  end

  def self.active_all_review
    Review.where(user_id: User.where(show_status: 2).pluck(:id), active: true)
  end


  # いいね通知機能
  def create_notification_like(current_user)

    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ",current_user.id, user_id,  id, "like"])
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
