class AddColumnActiveToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :active, :boolean, default: true
  end
end
