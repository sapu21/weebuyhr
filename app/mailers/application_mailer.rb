class ApplicationMailer < ActionMailer::Base
  default from: 'http://localhost:3000/users/sign_in'
  layout 'mailer'
end
