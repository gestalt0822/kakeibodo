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
    @challenge.total_amount = 0
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
      #基本ポイントは挑戦日数
      duration_point = @challenge.deadline.yday - @challenge.start.yday
      #目標額と使用額の差を計算
      #(例).1000円が目標で900円が使用額なら余裕率10%
      #http://qiita.com/ryoff/items/0eb270fbc8de96cf158f
      amount_point = @challenge.total_amount.to_f/@challenge.target.to_f
      amount_point *= 100
      amount_point = 100 - amount_point
      amount_point /= 100#余裕率を小数点で表す(10%なら0.1)
      #基本ポイントX余裕率のボーナス(例).基本ポイント30で余裕率10%なら33ポイント
      total_score = duration_point + duration_point * amount_point
      #継続回数を計算
      current_user.continue += 1
      current_user.save
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
