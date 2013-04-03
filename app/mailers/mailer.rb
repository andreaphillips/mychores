class Mailer < ActionMailer::Base
  default from: "mychores@eiscuer.com"

  def signup_notification(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to My Chores!")
  end

  def forgot_passcode(user)
    @user = user
    mail(:to => user.email, :subject => "Here's your passcode!")
  end

end
