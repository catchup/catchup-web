class CommentMailer < GlobalMailer
  def new_comment(comment)
    @comment = comment
    @card    = comment.card
    @user    = comment.user

    mail(subject: "New comment on card #{@card.title}")
  end
end
