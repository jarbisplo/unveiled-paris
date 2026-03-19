class ApplicationMailer < ActionMailer::Base
  default from: "Paris Unveiled <noreply@#{ENV.fetch('MAILGUN_DOMAIN', 'mail.unveiledparis.com')}>"
  layout "mailer"
end
