class CardMailSender
  def self.card_moved(card, move_params)
    users = card.involved_users - Array(move_params.fetch(:originated_by))

    return unless card.changed_list? && users.present?

    CardMailer.card_moved(card, users).deliver_now
  end

  def self.card_created(card, created_params)
    users = card.involved_users - Array(created_params.fetch(:originated_by))

    return unless users.present?

    CardMailer.new_card(card, users).deliver_now
  end

  def self.card_archived(card, archived_params)
    users = card.involved_users - Array(archived_params.fetch(:originated_by))

    return unless users.present?

    CardMailer.card_archived(card, users).deliver_now
  end

  def self.card_previewed(card, preview_url)
    # no-op
  end
end
