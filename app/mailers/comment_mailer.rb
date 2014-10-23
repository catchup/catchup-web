class CommentMailer < ActionMailer::Base
  helper ApplicationHelper

  default(from: "asd@pittle.org")

  def new_comment(comment, recipients)
    @comment = comment
    @card    = comment.card
    @user    = comment.user

    mail(subject: "New comment on card #{@card.title}", to: recipients.map(&:email))
  end
end
