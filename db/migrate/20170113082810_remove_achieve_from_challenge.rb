class RemoveAchieveFromChallenge < ActiveRecord::Migration
  def change
    remove_column :challenges, :achieve, :boolean
  end
end
