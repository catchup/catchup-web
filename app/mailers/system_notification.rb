module SystemNotification
  def self.included(mailer)
    mailer.default(from: "notifications@catchup.io")
  end
end
