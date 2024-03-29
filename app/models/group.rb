# frozen_string_literal: true

class Group < ApplicationRecord
  attachment :group_image
  has_many :group_users
  has_many :users, through: :group_users
  accepts_nested_attributes_for :group_users
  has_many :chats
  has_many :notifications, dependent: :destroy
  validates :name, :presence => { :message => "を入力してください" }
end
