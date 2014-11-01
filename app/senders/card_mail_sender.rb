class CardMailSender
  def self.card_moved(card, _)
    return unless card.changed_list? && card.involved_users.present?

    CardMailer.card_moved(card, card.involved_users).deliver
  end

  def self.card_created(card, _)
    return unless card.involved_users.present?

    CardMailer.new_card(card, card.involved_users).deliver
  end

  def self.card_archived(card)
    return unless card.involved_users.present?

    CardMailer.card_archived(card, card.involved_users).deliver
  end

  def self.card_previewed(card, preview_url)
    # no-op
  end
end
