class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.integer :myself_id
      t.timestamps
    end
  end
end
