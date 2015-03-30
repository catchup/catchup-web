class CardMailer < ActionMailer::Base
  include SystemNotification

  def new_card(card, originated_by, recipients)
    @card  = card
    @board = card.list.board

    mail_for_new_card_thread(card, originated_by, recipients)
  end

  def card_moved(card, originated_by, recipients)
    @list  = card.list
    @board = @list.board
    @card  = card

    mail_for_existing_card_thread(card, originated_by, recipients)
  end

  def card_archived(card, originated_by, recipients)
    @board = card.board
    @card  = card

    mail_for_existing_card_thread(card, originated_by, recipients)
  end
end
