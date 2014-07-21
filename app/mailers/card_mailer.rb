class CardMailer < ActionMailer::Base
  default(
    from: "asd@pittle.org",
    to: User.all.pluck(:email)
  )

  def new_card(card)
    @card  = card
    @board = card.list.board

    mail(subject: "New card on #{@board.title}")
  end

  def card_moved(card)
    @list = card.list
    @board = @list.board
    @card  = card

    mail(subject: "Card moved on #{@board.title}")
  end
end
