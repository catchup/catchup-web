require "test_helper"

class CommentMailerTest < ActionMailer::TestCase
  test "new_comment is sent to all the users" do
    involved_users     = [users(:ali)]
    irrelevant_comment = comments(:greeting)
    irrelevant_comment.stubs(:involved_users).returns(involved_users)

    email = CommentMailer.new_comment comments(:greeting)

    assert_equal involved_users.map(&:email), email.to
  end
end
