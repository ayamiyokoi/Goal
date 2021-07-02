class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title_string
      t.text :body
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
