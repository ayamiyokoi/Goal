# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :chat, :presence => {:message => "メッセージを入力してください"}
end
