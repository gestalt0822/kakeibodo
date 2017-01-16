class ChallengesController < ApplicationController
  #のちにモデルに移す(challenge.rb)
  #データベースに値を記憶するロジックを記述
  #http://qiita.com/regonn/items/4de94c5879cd65829a76

  def index
    @challenges = Challenge.all.order(created_at: :desc)
  end

  def new
    @challenge = Challenge.new
    if Challenge.find_by(status:1, user_id:current_user.id)
      redirect_to challenges_path, notice: "同時に複数のチャレンジを行うことはできません！既存のチャレンジ終了後に行って下さい。"
    end
  end

  def create
    @challenge = Challenge.new(challenges_params)
    @challenge.total_amount = 0
    @challenge.continue_times = 0
    @challenge.score = 0
    @challenge.user_id = current_user.id
    @challenge.start = Date.today
    #@challenge.save(total_amount, ...)でリファクタ
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

  def show
    @challenge = Challenge.find(params[:id])
    @challenges = @challenge.challenge_lists

      #基本ポイントは挑戦日数
      if @challenge.deadline.yday < @challenge.start.yday#年をまたぐ場合、チャレンジ期間に矛盾が生じないようにするための処理
        @duration_point = (@challenge.deadline.yday + 365) - @challenge.start.yday
      else
        @duration_point = @challenge.deadline.yday - @challenge.start.yday#チャレンジ期間を判定
      end
      @amount_point = @challenge.total_amount.to_f/@challenge.target.to_f#パーセントを小数点で表す(例).10%なら0.1
      @amount_point *= 100
      @amount_point = 100 - @amount_point
      @amount_point /= 100#余裕率を小数点で表す(10%なら0.1)
      #基本ポイントX余裕率のボーナス(例).基本ポイント30で余裕率10%なら33ポイント
      @amount_bonus = @duration_point * @amount_point #期間のボーナス、
      @total_score = @duration_point + @amount_bonus
  end

  #集計結果をusersテーブルのpointsカラムに追加
  #マイページにpointsを集計
  #過去のチャレンジ一覧にポイントも記載

  def finish
    @challenge = Challenge.find(params[:id])
    @challenge.update(status:2)
    if @challenge.total_amount <= @challenge.target#目標達成したかどうかを判定
      #基本ポイントは挑戦日数
      if @challenge.deadline.yday < @challenge.start.yday#年をまたぐ場合、チャレンジ期間に矛盾が生じないようにするための処理
        @duration_point = (@challenge.deadline.yday + 365) - @challenge.start.yday
      else
        @duration_point = @challenge.deadline.yday - @challenge.start.yday#チャレンジ期間を判定
      end
      #目標額と使用額の差を計算
      #(例).1000円が目標で900円が使用額なら余裕率10%
      #http://qiita.com/ryoff/items/0eb270fbc8de96cf158f
      @amount_point = @challenge.total_amount.to_f/@challenge.target.to_f#パーセントを小数点で表す(例).10%なら0.1
      @amount_point *= 100
      @amount_point = 100 - @amount_point
      @amount_point /= 100#余裕率を小数点で表す(10%なら0.1)
      #基本ポイントX余裕率のボーナス(例).基本ポイント30で余裕率10%なら33ポイント
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
      current_user.continue = 0
      current_user.save
      @challenge.update(score:0)
    end
  end

  private
    def challenges_params
      params.require(:challenge).permit(:deadline, :target)
    end
end
