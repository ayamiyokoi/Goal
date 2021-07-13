# frozen_string_literal: true

class Group < ApplicationRecord
  attachment :group_image
  has_many :group_users
  has_many :users, through: :group_users
  validates :name, presence: true, uniqueness: true
  has_many :chats
  
end
