class CardMailSender < CardObserver::Subscriber
  def card_moved(_)
    return unless model.changed_list? && recipients.present?

    CardMailer.card_moved(model, originated_by, recipients).deliver_now
  end

  def card_created(_)
    return unless recipients.present?

    CardMailer.new_card(model, originated_by, recipients).deliver_now
  end

  def card_archived
    return unless recipients.present?

    CardMailer.card_archived(model, originated_by, recipients).deliver_now
  end

  def card_previewed(preview_url)
    # no-op
  end

  private

  def recipients
    @recipients ||= model.involved_users - Array(originated_by)
  end
end
