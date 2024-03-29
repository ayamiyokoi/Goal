# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.text :group_image_id

      t.timestamps
    end
  end
end
