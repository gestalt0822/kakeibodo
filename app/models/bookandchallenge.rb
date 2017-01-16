class Bookandchallenge < ActiveRecord::Base
  belongs_to :booking, class_name: "Booking"
  belongs_to :challenge, class_name: "Challenge"
end
