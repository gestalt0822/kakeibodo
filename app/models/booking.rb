class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :sort
  has_many :booking_lists, foreign_key: "booking_id", class_name: "Bookandchallenge"
  scope :except_this_month, -> {where.not(date: Time.now.beginning_of_month..Time.now.end_of_month)}
  scope :this_month, -> {where(date: Time.now.beginning_of_month..Time.now.end_of_month)}
  scope :listed, -> {where(unlist:false)}
end
