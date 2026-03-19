class BookingMailer < ApplicationMailer
  default from: "Paris in Private <hello@parisinprivate.com>"

  def confirmation(booking)
    @booking = booking
    mail(to: @booking.email, subject: "Your tour is confirmed — #{@booking.package.name}")
  end
end
