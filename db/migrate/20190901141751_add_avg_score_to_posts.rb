# frozen_string_literal: true

class AddAvgScoreToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :avg_score, :float
    add_index :posts, :avg_score
  end
end
