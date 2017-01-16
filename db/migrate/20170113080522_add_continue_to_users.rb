class AddContinueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :continue, :integer, default: 0
  end
end
