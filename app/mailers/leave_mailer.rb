class LeaveMailer < ApplicationMailer
	default from: 'http://localhost:3000/users/sign_in'
 
  def leave_email
    @user = params[:user]
    @url  = 'http://localhost:3000/users/sign_in'
    mail(to: @user.email, subject: 'Application for leave')
  end
end
