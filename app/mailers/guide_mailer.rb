class GuideMailer < ApplicationMailer
  def new_booking(booking)
    @booking = booking
    mail(
      to:      ENV.fetch("GUIDE_EMAIL", "guides@mail.unveiledparis.com"),
      subject: "New booking — #{@booking.package.name} on #{@booking.tour_date&.strftime('%b %d')}"
    )
  end
end
