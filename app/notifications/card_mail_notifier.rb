class CardMailNotifier
  def self.card_moved(card, move_params)
    CardMailer.card_moved(card).deliver if card.changed_list?
  end

  def self.card_created(card, html)
    CardMailer.new_card(card).deliver
  end

  def self.card_archived(card)
    CardMailer.card_archived(card).deliver
  end
end
