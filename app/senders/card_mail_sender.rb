class CardMailSender
  attr_reader :card, :originated_by

  def initialize(card, originated_by)
    @card = card
    @originated_by = originated_by
  end

  def card_moved(_)
    return unless card.changed_list? && recipients.present?

    CardMailer.card_moved(card, originated_by, recipients).deliver_now
  end

  def card_created(_)
    return unless recipients.present?

    CardMailer.new_card(card, originated_by, recipients).deliver_now
  end

  def card_archived
    return unless recipients.present?

    CardMailer.card_archived(card, originated_by, recipients).deliver_now
  end

  def card_previewed(preview_url)
    # no-op
  end

  private

  def recipients
    @recipients ||= card.involved_users - Array(originated_by)
  end
end
