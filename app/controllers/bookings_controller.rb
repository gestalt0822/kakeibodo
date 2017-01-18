class BookingsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_booking, only: [:edit, :update, :destroy]

  def index
    @booking = Booking.new
    @bookings = Booking.where(user_id: current_user.id).order(date: :desc)
    @bookings_now = Booking.where(user_id: current_user.id, date: Time.now.beginning_of_month..Time.now.end_of_month).order(date: :desc)
    @bookings_then = Booking.where(user_id: current_user.id, date: Time.now.prev_month.beginning_of_month..Time.now.prev_month.end_of_month).order(date: :desc)
    this_month = Date.today.month
    this_year = Date.today.year
  end
  #http://www.namaraii.com/rubytips/datetime/#section-7

  def new
   @booking = Booking.new
   @categories = Category.all
  end

# コントローラーに書くべきでない処理はモデルに移す。
  def create
    @booking = Booking.new(bookings_params)
    @booking.user_id = current_user.id
    @booking.save
    @booking.update(sorts_params)
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
   @booking.update(sorts_params)
   redirect_to bookings_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end

  def get_sorts
    render partial: 'select_sort', locals: {sort_id: params[:category_id]}
  end

  private
    def bookings_params
      params.require(:booking).permit(:amount, :detail ,:date, :category_id, :sort_id)
    end

    def sorts_params
      params.require(:sort).permit(:sort_id)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end
end
