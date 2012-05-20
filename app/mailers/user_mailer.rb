class UserMailer < ActionMailer::Base
  default from: "notify@konvrge.com"

  def welcome_email(user)
    @user = user
    @url  = "http://www.konvrge.com/"
    mail(:to => @user.email, :subject => "Welcome to Konvrge")
  end

  def notify_answer_reply(user, link)
    @user = user
    @url  = "http://www.konvrge.com" + link
    mail(:to => @user.email, :subject => "Konvrge: Someone has replied to your question")
  end
end
