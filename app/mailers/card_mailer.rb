class CardMailer < ActionMailer::Base
  default(from: "asd@pittle.org")

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

  private

  def everyone
    User.all.pluck(:email)
  end
end
