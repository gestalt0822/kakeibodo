class UsersController < ApplicationController
  def index
    @users = User.all
  end

#毎回、計算していていいのか？
#challengesコントローラーでチャレンジ終了時にやるべきでは？
  def show
    @user = User.find(params[:id])
    if @user.challenges.where(user_id: @user.id)#該当ユーザーのチャレンジが存在している場合のみ以下実行
      @challenges = @user.challenges.where(user_id: @user.id)#該当ユーザーのチャレンジを取得
      total_scores = 0#全チャレンジの合計金額をtotal_scoresで扱う
      @challenges.each do |challenge|#全チャレンジのscoreカラムの値を合計
        if challenge.score
          total_scores += challenge.score
        end
      end
      @user.update(total_score: total_scores)
    end

    #合計スコアによって当てはまるランクを表示
    @your_score = current_user.total_score
    if Ranking.find(1).threshold > @your_score
      @ranking = Ranking.find(1).name
      @next_rank = Ranking.find(2).name
      @score_difference = Ranking.find(1).threshold - @your_score
      @message = Message.find(1).content
      @messenger = Message.find(1).messenger
    elsif Ranking.find(2).threshold > @your_score
      @ranking = Ranking.find(2).name
      @next_rank = Ranking.find(3).name
      @score_difference = Ranking.find(2).threshold - @your_score
      @message = Message.find(2).content
      @messenger = Message.find(2).messenger
    elsif Ranking.find(3).threshold > @your_score
      @ranking = Ranking.find(3).name
      @next_rank = Ranking.find(4).name
      @score_difference = Ranking.find(3).threshold - @your_score
      @message = Message.find(3).content
      @messenger = Message.find(3).messenger
    elsif Ranking.find(4).threshold > @your_score
      @ranking = Ranking.find(4).name
      @next_rank = Ranking.find(5).name
      @score_difference = Ranking.find(4).threshold - @your_score
      @message = Message.find(4).content
      @messenger = Message.find(4).messenger
    elsif Ranking.find(5).threshold > @your_score
      @ranking = Ranking.find(5).name
      @next_rank = Ranking.find(6).name
      @score_difference = Ranking.find(5).threshold - @your_score
      @message = Message.find(5).content
      @messenger = Message.find(5).messenger
    elsif Ranking.find(6).threshold > @your_score
      @ranking = Ranking.find(6).name
      @next_rank = Ranking.find(7).name
      @score_difference = Ranking.find(6).threshold - @your_score
      @message = Message.find(6).content
      @messenger = Message.find(6).messenger
    elsif Ranking.find(7).threshold > @your_score
      @ranking = Ranking.find(7).name
      @next_rank = Ranking.find(8).name
      @score_difference = Ranking.find(7).threshold - @your_score
      @message = Message.find(7).content
      @messenger = Message.find(7).messenger
    elsif Ranking.find(8).threshold > @your_score
      @ranking = Ranking.find(8).name
      @next_rank = Ranking.find(9).name
      @score_difference = Ranking.find(8).threshold - @your_score
      @message = Message.find(8).content
      @messenger = Message.find(8).messenger
    elsif Ranking.find(9).threshold > @your_score
      @ranking = Ranking.find(9).name
      @next_rank = Ranking.find(10).name
      @score_difference = Ranking.find(9).threshold - @your_score
      @message = Message.find(9).content
      @messenger = Message.find(9).messenger
    else
      @ranking = "ランク外"
      @next_rank = "ありません、あなたは最強だから"
      @score_difference = "0"
    end
  end
end
