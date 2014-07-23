class BaseMailer < ActionMailer::Base
  default(from: "asd@pittle.org")

  protected

  def everyone
    User.all.pluck(:email)
  end
end
