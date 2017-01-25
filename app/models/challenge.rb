class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :challenge_lists, foreign_key: "challenge_id", class_name: "Bookandchallenge"
  has_many :moneys, through: :challenge_lists, source: :booking#challengeから直接bookingsを取得
  enum achieve: {目標達成:true, 目標未達:false}

  def calculate_amount_point
    amount_point = self.total_amount.to_f/self.target.to_f#パーセントを小数点で表す(例).10%なら0.1
    amount_point *= 100
    amount_point = 100 - amount_point
    amount_point /= 100#余裕率を小数点で表す(10%なら0.1)
  end

  def calculate_duration_point
    if self.deadline.yday < self.start.yday#年をまたぐ場合、チャレンジ期間に矛盾が生じないようにするための処理
      duration_point = (self.deadline.yday + 365) - self.start.yday
    else
      duration_point = self.deadline.yday - self.start.yday#チャレンジ期間を判定
    end
  end
end
