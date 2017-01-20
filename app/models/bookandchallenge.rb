class Bookandchallenge < ActiveRecord::Base
  belongs_to :booking, class_name: "Booking", foreign_key: "booking_id"
  belongs_to :challenge, class_name: "Challenge"
end
