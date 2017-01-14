class ChallengesController < ApplicationController
  #のちにモデルに移す(challenge.rb)
  #データベースに値を記憶するロジックを記述
  #http://qiita.com/regonn/items/4de94c5879cd65829a76

  def index
    @challenges = Challenge.all.order(created_at: :desc)
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

  #集計結果をusersテーブルのpointsカラムに追加
  #マイページにpointsを集計
  #過去のチャレンジ一覧にポイントも記載

  def finish
    @challenge = Challenge.find(params[:id])
    @challenge.update(status:2)
    if @challenge.total_amount <= @challenge.target
      dif_amount = Point.find_by(name: "over_target").each_point
      this_dif_amount = (@challenge.target - @challenge.total_amount) * dif_amount
      dif_duration = Point.find_by(name: "duration").each_point
      this_dif_duration = (@challenge.deadline - @challenge.start).to_i * dif_duration
      current_user.continue += 1
      current_user.save
      total_score = this_dif_amount + this_dif_duration
       @challenge.update(achieve: true, score:total_score)
    else
      current_user.continue = 0
      current_user.save
      @challenge.update(score:0)
    end
    redirect_to challenges_path
  end

  private
    def challenges_params
      params.require(:challenge).permit(:deadline, :target)
    end
end
