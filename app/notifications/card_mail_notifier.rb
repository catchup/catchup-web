class CardMailNotifier
  def self.card_moved(card, move_params)
    CardMailer.card_moved(card).deliver if card.changed_list?
  end
end
