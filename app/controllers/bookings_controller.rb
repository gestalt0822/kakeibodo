class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end
  #http://www.namaraii.com/rubytips/datetime/#section-7

  def new
   @booking = Booking.new
  end

  def create
    @booking = Booking.new(bookings_params)
    @booking.date = Date.today
    @booking.save
    redirect_to bookings_path
  end

  private
    def bookings_params
      params.require(:booking).permit(:amount, :detail ,:date)
    end
end
