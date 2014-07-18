class CardMailer < ActionMailer::Base
  def new_card(card)
    @card  = card
    @board = card.list.board

    mail(
      from: "task-planner bot",
      to: User.all.pluck(:email),
      subject: "New card on #{@board.title}"
    )
  end

  def card_moved(card)
    @list = card.list
    @board = @list.board
    @card  = card

    mail(
      from: "task-planner bot",
      to: User.all.pluck(:email),
      subject: "Card moved on #{@board.title}"
    )
  end
end
