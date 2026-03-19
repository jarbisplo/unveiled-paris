module Admin
  class BookingsController < Admin::BaseController
    def index
      @bookings = Booking.includes(:package).order(created_at: :desc).page(params[:page]).per(30)
    end

    def show
      @booking = Booking.includes(:package).find(params[:id])
    end
  end
end
