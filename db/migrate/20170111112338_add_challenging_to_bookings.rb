class AddChallengingToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :challenging, :boolean, default: false
  end
end
