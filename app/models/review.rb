class Review < ApplicationRecord
  belongs_to :user
  has_many :review_tags
  has_many :tags, through: :review_tags
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
