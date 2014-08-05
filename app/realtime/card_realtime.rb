class CardRealtime
  def self.card_moved(card, move_params)
    trigger(
      card,
      :move_card,
      id: card.id, list_id: card.list_id, position: move_params.fetch(:position)
    )
  end

  def self.card_created(card, html)
    trigger(
      card,
      :new_card,
      id: card.id, list_id: card.list_id, html: html
    )
  end

  def self.card_archived(card)
    trigger(
      card,
      :archive_card,
      id: card.id, list_id: card.list_id
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
