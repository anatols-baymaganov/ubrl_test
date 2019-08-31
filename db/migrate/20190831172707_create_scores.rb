# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :value, limit: 1, null: false
    end
  end
end
