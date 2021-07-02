class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.integer :group_id
      t.text :chat

      t.timestamps
    end
  end
end
