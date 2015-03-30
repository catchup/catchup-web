module SystemNotification
  EMAIL_ADDRESS = "notifications@catchup.io"

  def self.included(mailer)
    mailer.default(from: EMAIL_ADDRESS)
  end

  def mail_with_display_name(params)
    display_name = params.fetch(:display_name)
    from = "#{display_name} <#{EMAIL_ADDRESS}>"

    mail params.merge(from: from)
  end
end
