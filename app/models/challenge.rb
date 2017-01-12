class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :challenge_lists, foreign_key: "challenge_id", class_name: "Bookandchallenge"
end
