class CommentMailer < BaseMailer
  def new_comment(comment)
    @comment = comment
    @card    = comment.card
    @user    = comment.user

    mail(
      subject: "New comment on card #{@card.title}",
      to: everyone
    )
  end
end
