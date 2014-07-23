require "test_helper"

class CommentMailerTest < ActionMailer::TestCase
  test "new_comment is sent to all the users" do
    email = CommentMailer.new_comment comments(:greeting)

    assert sent_to_everyone?(email)
  end
end
