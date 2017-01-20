class AddBookingsToUnlist < ActiveRecord::Migration
  def change
    add_column :bookings, :unlist, :boolean, default: false
  end
end
