# frozen_string_literal: true

class Group < ApplicationRecord
  attachment :group_image
  has_many :group_users
  has_many :users, through: :group_users
  has_many :chats

  validates :name, :presence => {:message => "を入力してください"}
  validates :date, :presence => {:message => "を入力してください"}
end
