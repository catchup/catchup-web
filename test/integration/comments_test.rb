require "test_helper"
require "pages/authentication_page"
require "pages/board_page"
require "pages/card_page"

class CommentsTest < ActionDispatch::IntegrationTest
  include AuthenticationPage
  include BoardPage
  include CardPage

  test "Anonymous views a card" do
    # Given I am anonymous
    # And I am on a new board with a card
    visit_boards
    create_board("a board")
    card = create_card("My Card")

    # When I want to comment on it
    show_card(card)

    # Then there must be no way for me to do it
    refute can_comment?
  end

  test "User comments on a card" do
    # Given I am signed in
    sign_in users(:antonio)

    # And I am on a new board with a card
    visit_boards
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
