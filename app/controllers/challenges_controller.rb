class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenges_params)
    @challenge.user_id = current_user.id
    @challenge.start = Date.today
    @challenge.save
    redirect_to challenges_path
  end

  private
    def challenges_params
      params.require(:challenge).permit(:deadline, :target)
    end
end
