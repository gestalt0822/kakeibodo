class RemoveChallengingFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :challenging, :boolean
  end
end
