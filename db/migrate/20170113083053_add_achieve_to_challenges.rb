class AddAchieveToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :achieve, :boolean, default: false, null: false
  end
end
