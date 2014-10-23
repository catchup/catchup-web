class CardMailer < ActionMailer::Base
  default(from: "asd@pittle.org")

  def new_card(card, recipients)
    @card  = card
    @board = card.list.board

    mail(subject: "New card on #{@board.title}", to: recipients.map(&:email))
  end

  def card_moved(card, recipients)
    @list  = card.list
    @board = @list.board
    @card  = card

    mail(subject: "Card moved on #{@board.title}", to: recipients.map(&:email))
  end

  def card_archived(card, recipients)
    @board = card.board
    @card  = card

    mail(subject: "Card archived on #{@board.title}", to: recipients.map(&:email))
  end
end
