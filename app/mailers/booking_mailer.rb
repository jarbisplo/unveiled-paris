class BookingMailer < ApplicationMailer
  default from: "Unveiled Paris <hello@unveiledparis.com>"

  def confirmation(booking)
    @booking = booking
    mail(to: @booking.email, subject: "Your tour is confirmed — #{@booking.package.name}")
  end
end
