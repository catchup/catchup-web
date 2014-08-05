class CardRealtime
  def self.card_moved(card, move_params)
    Pusher.trigger(
      "board_#{card.list.board_id}",
      "move_card",
      id: card.id, list_id: card.list_id, position: move_params.fetch(:position)
    )
  end
end
