class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :tag_id
      t.integer :rate
      t.text :review
      t.text :plan
      t.string :title
      t.text :topic

      t.timestamps
    end
  end
end
