require "test_helper"

class CommentMailerTest < ActionMailer::TestCase
  test "new_comment is sent to card involved users" do
    involved_users     = [users(:ali)]
    email = CommentMailer.new_comment(comments(:greeting), involved_users)

    assert_equal involved_users.map(&:email), email.to
  end
end
