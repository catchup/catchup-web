class CommentMailSender
  def self.new_comment(comment)
    return unless comment.involved_users.present?

    CommentMailer.new_comment(comment, comment.involved_users).deliver_now
  end
end
