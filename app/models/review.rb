class Review < ApplicationRecord
  belongs_to :user
  has_many :review_tags
  has_many :tags, through: :review_tags
  
end
