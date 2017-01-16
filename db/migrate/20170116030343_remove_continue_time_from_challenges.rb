class RemoveContinueTimeFromChallenges < ActiveRecord::Migration
  def change
    remove_column :challenges, :continue_times, :integer
  end
end
