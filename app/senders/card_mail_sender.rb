class CardMailSender
  def self.card_moved(card, originated_by:)
    users = card.involved_users - Array(originated_by)

    return unless card.changed_list? && users.present?

    CardMailer.card_moved(card, users).deliver_now
  end

  def self.card_created(card, originated_by:)
    users = card.involved_users - Array(originated_by)

    return unless users.present?

    CardMailer.new_card(card, users).deliver_now
  end

  def self.card_archived(card, originated_by:)
    users = card.involved_users - Array(originated_by)

    return unless users.present?

    CardMailer.card_archived(card, users).deliver_now
  end

  def self.card_previewed(card, preview_url)
    # no-op
  end
end
