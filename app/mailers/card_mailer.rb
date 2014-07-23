class CardMailer < BaseMailer
  def new_card(card)
    @card  = card
    @board = card.list.board

    mail(
      subject: "New card on #{@board.title}",
      to: everyone
    )
  end

  def card_moved(card)
    @list = card.list
    @board = @list.board
    @card  = card

    mail(
      subject: "Card moved on #{@board.title}",
      to: everyone
    )
  end
end
