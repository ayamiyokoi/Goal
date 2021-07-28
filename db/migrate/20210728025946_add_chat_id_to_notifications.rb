class AddChatIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :chat_id, :integer
    add_column :notifications, :group_id, :integer
  end
end
