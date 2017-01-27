class UsersController < ApplicationController
  def index
    @users = User.where(public:true).order(total_score: :desc)
    if current_user.public == true
      @users_rank = @users.pluck(:id)
      @your_rank = @users_rank.index(current_user.id)
      next_rank = @your_rank -= 1#次の順位の配列内で何番目か取得
      @your_rank += 2
      next_rank_id = @users_rank[next_rank]#次の順位の人のidを取得
      next_user = User.find(next_rank_id)#次の順位の人のレコードを取得
      @next_rank = next_rank + 1
      @difference = next_user.total_score - current_user.total_score
    end
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
      if Ranking.find(i).threshold >= @your_score
        @ranking = Ranking.find(i).name
        @next_rank = Ranking.find(i+1).name
        @score_difference = (Ranking.find(i).threshold - @your_score).round(2)
        @message = Message.find(i).content
        @messenger = Message.find(i).messenger
        break
      else
        i = i +1
      end
    end

    if Ranking.find(10).threshold < @your_score
      @ranking = "ランク外"
      @next_rank = "ありません、あなたは最強だから"
      @score_difference = 0
      @message = Message.find(11).content
      @messenger = Message.find(11).messenger
    end
  end
end
