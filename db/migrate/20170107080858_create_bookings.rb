class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :detail
      t.integer :amount
      t.datetime :date
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
