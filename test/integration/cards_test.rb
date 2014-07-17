require "test_helper"
require "pages/board_page"

class CardsTest < ActionDispatch::IntegrationTest
  include BoardPage

  setup do
    Capybara.current_driver = Capybara.javascript_driver

    visit_boards
  end

  teardown do
    Capybara.use_default_driver
  end

  test "User drags cards to other lists" do
    # Given a new board with a card
    create_board("a board")
    card = create_card(
      "My Card",
      on: lists.first
    )

    # When I drag a card to another list
    another_list = lists.second
    card.drag_to cards_container_for_list(another_list)

    # Then that card should stick to the new list
    within another_list do
      assert has_card?("My Card")
    end

    # And its position should be persisted
    refresh

    # We have to fetch back the list again, because the dom has changed via
    # refresh :(
    another_list = lists.second
    within another_list do
      assert has_card?("My Card")
    end
  end

  test "User creates a card while other users are on the same page" do
    # Given a new board
    Capybara.session_name = :default
    create_board("a board")

    # And another user on the same board
    Capybara.session_name = :another
    visit_board("a board")

    # When I create a card
    Capybara.session_name = :default
    create_card(
      "User 1 Card",
      on: lists.first
    )

    # Then the other user sees it in realtime
    Capybara.session_name = :another
    within lists.first do
      assert has_card?("User 1 Card")
    end
  end
end
