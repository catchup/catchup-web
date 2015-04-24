class CommentMailer < ActionMailer::Base
  include SystemNotification

  helper ApplicationHelper

  def new_comment(comment, originated_by, recipients)
    @comment = comment
    @card    = comment.card
    @board   = @card.board
    @user    = originated_by

    mail_for_existing_card_thread(@card, originated_by, recipients)
  end
end
