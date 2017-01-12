class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :sort
  has_many :booking_lists, foreign_key: "booking_id", class_name: "Bookandchallenge"

  #現在のユーザーが実施中のチャレンジがあるかどうかを判定
  def self.now_challenging?
    if Challenge.where(status: 1, user_id:current_user.id)
      return true
    else
      return false
    end
  end
end
