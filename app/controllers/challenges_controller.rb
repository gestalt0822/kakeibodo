class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:edit, :update, :show, :finish]

  def index
    @challenges = Challenge.all.order(created_at: :desc)
    @challenge = Challenge.new
    @challenge_now = Challenge.where(user_id: current_user.id, status:1)
    @challenge_then = Challenge.where(user_id: current_user.id, status:2)
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenges_params)
    @challenge.attributes = {total_amount:0, score:0, user_id:current_user.id, start:Date.today}
    @challenge.save
    redirect_to challenges_path
  end

  def edit
  end

  def update
    @challenge.update(challenges_params)
    redirect_to challenges_path
  end

  def show
    @challenges = @challenge.challenge_lists
    @duration_point = @challenge.calculate_duration_point#挑戦日数を計算(challenge.rb)
    @amount_point = @challenge.calculate_amount_point#余裕率を計算(challenge.rb)
    #基本ポイントX余裕率のボーナス(例).基本ポイント30で余裕率10%なら33ポイント
    @amount_bonus = @duration_point * @amount_point #期間のボーナス、
    @total_score = @duration_point + @amount_bonus
  end

  #集計結果をusersテーブルのpointsカラムに追加
  #マイページにpointsを集計
  #過去のチャレンジ一覧にポイントも記載

  def finish
    @challenge.update(status:2, total_amount:@challenge.moneys.sum(:amount))

    if @challenge.total_amount <= @challenge.target#目標達成したかどうかを判定
      @duration_point = @challenge.calculate_duration_point#チャレンジ期間を判定
      @amount_point = @challenge.calculate_amount_point#余裕率を計算(challenge.rb)
      @amount_bonus = @duration_point * @amount_point #期間のボーナス、
      @total_score = @duration_point + @amount_bonus
      #継続回数を計算&挑戦日数が28日以上の場合は継続ポイントを加算
      if @duration_point >= 28
        current_user.continue += 1
        current_user.save
        @bonus_point = current_user.continue * @duration_point/10
        @total_score += @bonus_point
      end
      @challenge.update(achieve: true, score:@total_score)
    else
      current_user.update(continue:0)
      @challenge.update(score:0)
    end
  end

  private
    def challenges_params
      params.require(:challenge).permit(:deadline, :target)
    end

    def set_challenge
      @challenge = Challenge.find(params[:id])
    end
end
