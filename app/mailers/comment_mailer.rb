class CommentMailer < ActionMailer::Base
  include SystemNotification

  helper ApplicationHelper

  def new_comment(comment, recipients)
    @comment = comment
    @card    = comment.card
    @board   = @card.board
    @user    = comment.user

    mail(
      subject: "Re: [#{@board.title}] #{@card.title}",
      to: recipients.map(&:email)
    )
  end
end
