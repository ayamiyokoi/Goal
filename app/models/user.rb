class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :chats, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # フォロー機能
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_follows, source: :follower

  has_many :follows, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :follows, source: :followed

  def follow(user_id)
    follows.create(followed_id: user_id)
  end
  def unfollow(user_id)
    follows.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end

  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review
  
  
  # フォロー通知機能
  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
