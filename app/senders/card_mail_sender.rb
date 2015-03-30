class CardMailSender
  def self.card_moved(card, originated_by, _)
    users = card.involved_users - Array(originated_by)

    return unless card.changed_list? && users.present?

    CardMailer.card_moved(card, originated_by, users).deliver_now
  end

  def self.card_created(card, originated_by, _)
    users = card.involved_users - Array(originated_by)

    return unless users.present?

    CardMailer.new_card(card, originated_by, users).deliver_now
  end

  def self.card_archived(card, originated_by)
    users = card.involved_users - Array(originated_by)

    return unless users.present?

    CardMailer.card_archived(card, originated_by, users).deliver_now
  end

  def self.card_previewed(card, originated_by, preview_url)
    # no-op
  end
end
