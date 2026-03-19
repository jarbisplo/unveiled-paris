class GuideMailer < ApplicationMailer
  def new_booking(booking, to: nil)
    @booking = booking
    recipients = to || ENV.fetch("GUIDE_EMAIL", "guides@mail.unveiledparis.com")
    mail(
      to:      recipients,
      subject: "New booking — #{@booking.package.name} on #{@booking.tour_date&.strftime('%b %d')}"
    )
  end
end
