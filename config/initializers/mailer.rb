Rails.application.configure do
  config.action_mailer.default_options = { from: 'no-reply@example.com' }
  config.mailer = 'UserMailer'
end