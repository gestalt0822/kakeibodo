class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.integer :user_id
      t.datetime :start
      t.datetime :deadline
      t.integer :total_amount
      t.integer :target
      t.boolean :achieve
      t.integer :continue_times
      t.integer :score
      t.timestamps null: false
    end
  end
end
