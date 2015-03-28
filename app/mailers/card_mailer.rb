class CardMailer < ActionMailer::Base
  include SystemNotification

  def new_card(card, recipients)
    @card  = card
    @board = card.list.board

    mail(
      subject: "#{@board.title}: #{@card.title}", to: recipients.map(&:email)
    )
  end

  def card_moved(card, recipients)
    @list  = card.list
    @board = @list.board
    @card  = card

    mail(
      subject: "Re: [#{@board.title}] #{@card.title}", to: recipients.map(&:email)
    )
  end

  def card_archived(card, recipients)
    @board = card.board
    @card  = card

    mail(
      subject: "Re: [#{@board.title}] #{@card.title}",
      to: recipients.map(&:email)
    )
  end
end
