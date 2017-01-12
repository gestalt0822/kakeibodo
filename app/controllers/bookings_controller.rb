class BookingsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_booking, only: [:edit, :update, :destroy]

  def index
    @booking = Booking.new
    @bookings = Booking.all
  end
  #http://www.namaraii.com/rubytips/datetime/#section-7

  def new
   @booking = Booking.new
   @categories = Category.all
  end

# コントローラーに書くべきでない処理はモデルに移す。
# challengesテーブルのtotal_amountカラムにamountカラムの金額を追加(中間テーブルを経由)
# 特定のカラムの特定の値(challenge_idが同じ値)をすべて配列などで取得するメソッドが欲しい
# さらに取得した値を合計したい
# Bookandchallenge.where(challenge_id:get_challenge.last.id)
# これも一度コントローラーに記述して動くのを確認してからモデルに移す。

  def create
    @booking = Booking.new(bookings_params)
    @booking.user_id = current_user.id
    @booking.save

    if current_user.challenges.find_by(status: 1, user_id:current_user.id)
      get_challenge = Challenge.where(user_id:current_user.id,status:1)
      get_booking = Booking.where(user_id:current_user.id,).last
      Bookandchallenge.create(challenge_id:get_challenge.last.id ,booking_id:get_booking.id)
      challengeId = current_user.challenges.find_by(status:1).id
      challengings = Bookandchallenge.where(challenge_id: challengeId )
      amounts = 0
      challengings.each do |challenging |
        amounts += challenging.booking.amount
      end
      latest_challenge = current_user.challenges.find_by(status:1)
      latest_challenge.update(total_amount: amounts)
    end
      redirect_to bookings_path
  end

  def edit
   @booking = Booking.find(params[:id])
  end

  def update
   @booking = Booking.find(params[:id])
   @booking.update(bookings_params)
   redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  private
    def bookings_params
      params.require(:booking).permit(:amount, :detail ,:date, :category_id, :sort_id)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end
end
