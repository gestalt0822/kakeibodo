class UsersController < ApplicationController
  def index
    @users = User.all
  end

#毎回、計算していていいのか？
#challengesコントローラーでチャレンジ終了時にやるべきでは？
  def show
    @user = User.find(params[:id])
    if @user.challenges.where(user_id: @user.id)
      @challenges = @user.challenges.where(user_id: @user.id)
      total_scores = 0
      @challenges.each do |challenge|
        if challenge.score
          total_scores += challenge.score
        end
      end
      @user.update(total_score: total_scores)
    end

    @your_score = current_user.total_score
    if Ranking.find(1).threshold > @your_score
      @ranking = Ranking.find(1).name
      @next_rank = Ranking.find(2).name
      @score_difference = Ranking.find(1).threshold - @your_score
    elsif Ranking.find(2).threshold > @your_score
      @ranking = Ranking.find(2).name
    elsif Ranking.find(3).threshold > @your_score
      @ranking = Ranking.find(3).name
    elsif Ranking.find(4).threshold > @your_score
      @ranking = Ranking.find(4).name
    elsif Ranking.find(5).threshold > @your_score
      @ranking = Ranking.find(5).name
    elsif Ranking.find(6).threshold > @your_score
      @ranking = Ranking.find(6).name
    elsif Ranking.find(7).threshold > @your_score
      @ranking = Ranking.find(7).name
    elsif Ranking.find(8).threshold > @your_score
      @ranking = Ranking.find(9).name
    elsif Ranking.find(10).threshold > @your_score
      @ranking = Ranking.find(10).name
    else
      @ranking = "ランク外"
    end
  end
end
