class LeaveMailer < ApplicationMailer
	default :from => 'any_from_address@example.com'
 
  def leave_email(user)
    @user = user
    mail(to: @user.email, :subject => "Leave application")
  end
end
