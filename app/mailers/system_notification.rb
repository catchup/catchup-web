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

  def mail_for_new_card_thread(card, originated_by, recipients)
    mail_with_display_name(
      display_name: originated_by.first_name,
      subject: "#{card.board.title}: #{card.title} (##{card.id})",
      to: recipients.map(&:email)
    )
  end

  def mail_for_existing_card_thread(card, originated_by, recipients)
    mail_with_display_name(
      display_name: originated_by.first_name,
      subject: "Re: [#{card.board.title}] #{card.title} (##{card.id})",
      to: recipients.map(&:email)
    )
  end
end
