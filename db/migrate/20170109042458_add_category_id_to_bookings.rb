class AddCategoryIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :category_id, :integer
  end
end
