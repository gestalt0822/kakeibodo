class BookingsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_booking, only: [:edit, :update, :destroy]

  def index
    @booking = Booking.new
    @bookings = Booking.where(user_id: current_user.id).order(date: :desc)
    @bookings_now = Booking.where(user_id: current_user.id, date: Time.now.beginning_of_month..Time.now.end_of_month).order(date: :desc)
    @bookings_then = current_user.bookings.where.not(date: Time.now.beginning_of_month..Time.now.end_of_month).order(date: :desc)
    this_month = Date.today.month
    this_year = Date.today.year
    @category = Category.new
    @categories = Category.all
    @sort = Sort.new
    @sorts = Sort.all
  end
  #http://www.namaraii.com/rubytips/datetime/#section-7

  def new
    @booking = Booking.new
    @category = Category.new
    @categories = Category.all
    @sort = Sort.new
    @sorts = Sort.all
  end

# コントローラーに書くべきでない処理はモデルに移す。
  def create
    @booking = Booking.new(bookings_params)
    @booking.user_id = current_user.id
    @booking.save
    @booking.update(sorts_params)
    if current_user.challenges.find_by(status: 1, user_id:current_user.id)#現在のユーザーが実施中のチャレンジがあるか？
      get_challenge = Challenge.where(user_id:current_user.id,status:1)#現在のチャレンジを取得
      get_booking = Booking.where(user_id:current_user.id,).last#保存したばかりののbookingsレコードを取得
      Bookandchallenge.create(challenge_id:get_challenge.last.id ,booking_id:get_booking.id)#Bookandhcallengeの新レコードを作成保存
      # challengeId = current_user.challenges.find_by(status:1).id#在のユーザーが実施中のチャレンジのidを取得
      # challengings = Bookandchallenge.where(challenge_id: challengeId )#同一チャレンジidのBookandchallengeのレコードをすべて取得
      # # amounts = 0
      # # challengings.each do |challenging |
      # #   amounts += challenging.booking.amount
      # # end
      # latest_challenge = current_user.challenges.find_by(status:1)
      # # latest_challenge.update(total_amount: amounts)
    end
      redirect_to bookings_path
  end

  def edit
   @booking = Booking.find(params[:id])
   @category = Category.new
   @categories = Category.all
   @sort = Sort.new
   @sorts = Sort.all
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

  def unlist
    @booking = Booking.find(params[:id])
    @booking.update(unlist: true)
    redirect_to bookings_path
  end

  def new_category
    @category = Category.create(categories_params)
    redirect_to bookings_path
  end

  def new_sort
    @sort = Sort.create(sorts_params)
    redirect_to bookings_path
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

    def categories_params
      params.require(:category).permit(:name)
    end

    def sorts_params
      params.require(:sort).permit(:name, :category_id)
    end
end
