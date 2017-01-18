class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :sort
  has_many :booking_lists, foreign_key: "booking_id", class_name: "Bookandchallenge"
end
