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
end
