class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :challenge_lists, foreign_key: "challenge_id", class_name: "Bookandchallenge"

  enum achieve: {目標達成:true, 目標未達:false}

  def get_total_amount
    challengeId = current_user.challenges.find_by(status:1).id
    challengings = Bookandchallenge.where(challenge_id: challengeId )
    amounts = 0
    challengings.each do |challenging |
      amounts += challenging.booking.amount
    end
    latest_challenge = current_user.challenges.find_by(status:1)
    latest_challenge.update(total_amount: amounts)
  end
end
