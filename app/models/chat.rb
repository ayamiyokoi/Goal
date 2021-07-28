# frozen_string_literal: true

class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :notifications, dependent: :destroy
  validates :chat, :presence => { :message => "を入力してください" }

  # チャット通知機能
  def create_notification_chat(current_user, group_id, chated_ids, chat_id)
    # 自分のグループで自分以外にチャットしている人をすべて取得し、通知を送る
    save_notification_chat(current_user, group_id, chated_ids, chat_id)
  end

  def save_notification_chat(current_user, group_id, visited_id, chat_id)
    # チャットは複数回することが考えられるため、１つのグループに複数回通知する
    notification = current_user.active_notifications.new(
      group_id: group_id,
      chat_id: chat_id,
      visited_id: visited_id,
      action: "chat"
    )
    # 自分が自分のグループに対しチャットする場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
