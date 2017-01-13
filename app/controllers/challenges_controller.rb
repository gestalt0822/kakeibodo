class ChallengesController < ApplicationController
  #bookandchallengesテーブルの該当するchallenge_idの各booking_idに紐付いたamountカラムの値を合計する
  #のちにモデルに移す(challenge.rb)

  #紐付いたchallge_idのbookandchallengesテーブルのレコードをwhereメソッドですべて取得(配列)
  #配列の数を数えて変数iに代入
  #for文で繰り返し処理をして合計、結果を変数に代入
  #viewで変数を表示
  #データベースに値を記憶するロジックを記述
  #http://qiita.com/regonn/items/4de94c5879cd65829a76
  #


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

  def edit
    @challenge = Challenge.find(params[:id])
  end

  def update
    @challenge = Challenge.find(params[:id])
    @challenge.update(challenges_params)
    redirect_to challenges_path
  end

  private
    def challenges_params
      params.require(:challenge).permit(:deadline, :target)
    end
end
