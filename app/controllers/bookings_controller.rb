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

  def create
    @booking = Booking.new(bookings_params)
    @booking.user_id = current_user.id
    @booking.save
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
      params.require(:booking).permit(:amount, :detail ,:date)
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end
end
