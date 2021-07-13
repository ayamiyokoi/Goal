# frozen_string_literal: true

class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :name
      t.datetime :date
      t.boolean :achieved, default: false, null: false

      t.timestamps
    end
  end
end
