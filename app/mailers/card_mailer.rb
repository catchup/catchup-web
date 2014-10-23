class CardMailer < ActionMailer::Base
  default(from: "asd@pittle.org")

  def new_card(card)
    @card  = card
    @board = card.list.board
    recipients = card.involved_users.map(&:email)

    mail(subject: "New card on #{@board.title}", to: recipients)
  end

  def card_moved(card)
    @list  = card.list
    @board = @list.board
    @card  = card
    recipients = card.involved_users.map(&:email)

    mail(subject: "Card moved on #{@board.title}", to: recipients)
  end

  def card_archived(card)
    @board = card.board
    @card  = card
    recipients = card.involved_users.map(&:email)

    mail(subject: "Card archived on #{@board.title}", to: recipients)
  end
end
