class CardRealtime
  def self.card_moved(card, originated_by, move_params)
    trigger(
      card,
      :move_card,
      id: card.id, list_id: card.list_id, position: move_params.fetch(:position)
    )
  end

  def self.card_created(card, originated_by, html)
    trigger(
      card,
      :new_card,
      id: card.id, list_id: card.list_id, html: html
    )
  end

  def self.card_archived(card, originated_by)
    trigger(
      card,
      :archive_card,
      id: card.id, list_id: card.list_id
    )
  end

  def self.card_previewed(card, originated_by, preview_url)
    trigger(
      card,
      :preview_card,
      id: card.id, preview_url: preview_url
    )
  end

  def self.trigger(card, event_name, params)
    Pusher.trigger(
      "board_#{card.list.board_id}",
      event_name.to_s,
      params
    )
  end
end
