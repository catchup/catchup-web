class CardRealtime
  attr_reader :card, :originated_by

  def initialize(card, originated_by)
    @card = card
    @originated_by = originated_by
  end

  def card_moved(move_params)
    trigger_event(:move_card, position: move_params.fetch(:position))
  end

  def card_created(html)
    trigger_event(:new_card, html: html)
  end

  def card_archived
    trigger_event(:archive_card)
  end

  def card_previewed(preview_url)
    trigger_event(:preview_card, preview_url: preview_url)
  end

  private

  def trigger_event(event_name, params = {})
    event_details = params.merge(id: card.id, list_id: card.list_id)
    Pusher.trigger("board_#{card.board.id}", event_name.to_s, event_details)
  end
end
