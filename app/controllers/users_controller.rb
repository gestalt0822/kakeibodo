class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if @user.challenges.where(user_id: @user.id)
      @challenges = @user.challenges.where(user_id: @user.id)
      total_scores = 0
      @challenges.each do |challenge|
        total_scores += challenge.score
      end
      @user.update(total_score: total_scores)
    end
  end
end
