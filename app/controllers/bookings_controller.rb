class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @packages = Package.all
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.status = :pending

    if @booking.save
      if ENV["STRIPE_SECRET_KEY"].present?
        session = create_stripe_session(@booking)
        @booking.update_column(:stripe_session_id, session.id)
        redirect_to session.url, allow_other_host: true
      else
        @booking.update_column(:status, Booking.statuses[:confirmed])
        BookingMailer.confirmation(@booking).deliver_later
        redirect_to booking_success_path
      end
    else
      @packages = Package.all
      render :new, status: :unprocessable_entity
    end
  end

  def success
    if params[:session_id].present? && ENV["STRIPE_SECRET_KEY"].present?
      Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
      stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
      @booking = Booking.find_by(stripe_session_id: params[:session_id])
      if @booking && stripe_session.payment_status == "paid"
        @booking.update(status: :confirmed, amount_paid_cents: stripe_session.amount_total)
        BookingMailer.confirmation(@booking).deliver_later
      end
    end
  end

  def cancelled
  end

  private

  def booking_params
    params.require(:booking).permit(
      :first_name, :last_name, :email, :phone,
      :tour_date, :group_size, :package_id, :special_requests
    )
  end

  def create_stripe_session(booking)
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
    Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items: [{
        price_data: {
          currency: "usd",
          product_data: { name: booking.package.name },
          unit_amount: booking.package.price_cents
        },
        quantity: booking.group_size
      }],
      mode: "payment",
      success_url: booking_success_url(session_id: "{CHECKOUT_SESSION_ID}"),
      cancel_url: booking_cancelled_url
    )
  end
end
