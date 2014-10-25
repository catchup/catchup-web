module SystemNotification
  def self.included(mailer)
    mailer.default(from: "asd@pittle.org")
  end
end
