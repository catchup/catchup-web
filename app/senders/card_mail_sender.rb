class CardMailSender
  def self.card_moved(card, _)
    CardMailer.card_moved(card).deliver if card.changed_list?
  end

  def self.card_created(card, _)
    CardMailer.new_card(card).deliver
  end

  def self.card_archived(card)
    CardMailer.card_archived(card).deliver
  end
end
