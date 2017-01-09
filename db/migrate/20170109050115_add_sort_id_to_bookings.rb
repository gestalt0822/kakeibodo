class AddSortIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :sort_id, :integer
  end
end
