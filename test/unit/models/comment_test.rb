require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "involved users are the same as card ones" do
    card    = stub(involved_users: [stub, stub])
    comment = comments(:greeting)
    comment.stubs(:card).returns(card)

    assert_equal card.involved_users, comment.involved_users
  end
end
