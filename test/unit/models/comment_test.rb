require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "involved users are the same as card ones without the creator" do
    comment = comments(:greeting)
    comment.card.stubs(:involved_users).returns([users(:ali), comment.user])

    assert_equal [users(:ali)], comment.involved_users
  end
end
