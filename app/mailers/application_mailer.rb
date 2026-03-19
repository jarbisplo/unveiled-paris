class ApplicationMailer < ActionMailer::Base
  default from: "Unveiled Paris <noreply@#{ENV.fetch('MAILGUN_DOMAIN', 'mail.unveiledparis.com')}>"
  layout "mailer"
end
