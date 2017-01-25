class UsersController < ApplicationController
  def index
    @users = User.all
  end

#usersテーブルのtotal_scoresからむは不要？？
  def show
    @user = User.find(params[:id])
    if @user.challenges.where(user_id: @user.id)#該当ユーザーのチャレンジが存在している場合のみ以下実行
      @your_score = @user.challenges.sum(:score)
    end

    #合計スコアによって当てはまるランクを表示
    i = 1

    while i < 10 do
      if Ranking.find(i).threshold > @your_score
        @ranking = Ranking.find(i).name
        @next_rank = Ranking.find(i+1).name
        @score_difference = Ranking.find(i).threshold - @your_score
        @message = Message.find(i).content
        @messenger = Message.find(i).messenger
        break
      else
        i = i +1
      end
    end

    if Ranking.find(10).threshold <= @your_score
      @ranking = "ランク外"
      @next_rank = "ありません、あなたは最強だから"
      @score_difference = "0"
    end
  end
end
