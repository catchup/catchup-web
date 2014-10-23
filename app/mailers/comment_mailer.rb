class CommentMailer < ActionMailer::Base
  helper ApplicationHelper

  default(from: "asd@pittle.org")

  def new_comment(comment)
    @comment = comment
    @card    = comment.card
    @user    = comment.user
    recipients = comment.involved_users.map(&:email)

    mail(subject: "New comment on card #{@card.title}", to: recipients)
  end
end
