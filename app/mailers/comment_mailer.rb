class CommentMailer < ActionMailer::Base
  include SystemNotification

  helper ApplicationHelper

  def new_comment(comment, originated_by, recipients)
    @comment = comment
    @card    = comment.card
    @board   = @card.board
    @user    = originated_by

    mail_with_display_name(
      display_name: originated_by.first_name,
      subject: "Re: [#{@board.title}] #{@card.title}",
      to: recipients.map(&:email)
    )
  end
end
