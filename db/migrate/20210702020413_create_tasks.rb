class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.text :body
      t.datetime :date
      t.boolean :finished, default: false, null: false

      t.timestamps
    end
  end
end
