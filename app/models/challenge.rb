class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :challenge_lists, foreign_key: "challenge_id", class_name: "Bookandchallenge"
  has_many :moneys, through: :challenge_lists, source: :booking#challengeから直接bookingsを取得

  enum achieve: {目標達成:true, 目標未達:false}

  
end
