class GlobalMailer < ActionMailer::Base
  default(from: "asd@pittle.org")
  default(to: Proc.new { everyone })

  protected

  def everyone
    User.all.pluck(:email)
  end
end
