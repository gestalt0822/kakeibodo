class Category < ActiveRecord::Base
  has_many :sorts, dependent: :destroy
  has_many :bookings
end
