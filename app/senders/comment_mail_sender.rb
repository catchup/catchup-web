class CommentMailSender
  def self.new_comment(comment, originated_by)
    users = comment.involved_users - Array(originated_by)

    return unless users.present?

    CommentMailer.new_comment(comment, originated_by, users).deliver_now
  end
end
