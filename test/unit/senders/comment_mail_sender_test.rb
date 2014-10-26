require "test_helper"

class CommentMailSenderTest < ActionMailer::TestCase
  def setup
    @irrelevant_comment = comments(:greeting)
  end

  test "sends an e-mail when someone is involved in a comment" do
    @irrelevant_comment.card.stubs(:involved_users).returns([users(:ali)])
    CommentMailSender.new_comment(@irrelevant_comment)
    assert delivered_email?
  end

  test "does not send any e-mail when nobody is involved in a comment" do
    @irrelevant_comment.card.stubs(:involved_users).returns([])
    CommentMailSender.new_comment(@irrelevant_comment)
    refute delivered_email?
  end
end
