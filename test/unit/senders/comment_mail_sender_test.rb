require "test_helper"

class CommentMailSenderTest < ActionMailer::TestCase
  def setup
    @irrelevant_comment = comments(:greeting)
    @irrelevant_comment.card.stubs(:involved_users).returns([users(:ali)])
  end

  test "sends an e-mail when someone is involved in a comment" do
    CommentMailSender.new_comment(@irrelevant_comment, users(:antonio))
    assert delivered_email?
  end

  test "does not send any e-mail when nobody is involved in a comment" do
    CommentMailSender.new_comment(@irrelevant_comment, users(:ali))
    refute delivered_email?
  end
end
