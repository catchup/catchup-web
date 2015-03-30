class CardMailer < ActionMailer::Base
  include SystemNotification

  def new_card(card, originated_by, recipients)
    @card  = card
    @board = card.list.board

    mail_with_display_name(
      display_name: originated_by.first_name,
      subject: "#{@board.title}: #{@card.title}",
      to: recipients.map(&:email)
    )
  end

  def card_moved(card, originated_by, recipients)
    @list  = card.list
    @board = @list.board
    @card  = card

    mail_with_display_name(
      display_name: originated_by.first_name,
      subject: "Re: [#{@board.title}] #{@card.title}",
      to: recipients.map(&:email)
    )
  end

  def card_archived(card, originated_by, recipients)
    @board = card.board
    @card  = card

    mail_with_display_name(
      display_name: originated_by.first_name,
      subject: "Re: [#{@board.title}] #{@card.title}",
      to: recipients.map(&:email)
    )
  end
end
