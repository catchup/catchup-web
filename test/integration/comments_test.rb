require "test_helper"
require "pages/board_page"
require "pages/card_page"

class CommentsTest < ActionDispatch::IntegrationTest
  include BoardPage
  include CardPage

  test "User comments on a card" do
    # Given I am signed in
    sign_in users(:antonio)

    # And I am on a new board with a card
    create_board("a board")
    card = create_card("Preview Feature")

    # When I comment on it
    comment = "This feature is freekin' cool!"
    show_card(card)
    leave_comment(comment)

    # Then I see the comment that I have left
    assert has_comment?(comment)
  end
end
