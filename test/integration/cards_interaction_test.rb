require "test_helper"
require "pages/board_page"
require "pages/card_page"
require "integration/javascript_test"

class CardsInteractionTest < JavascriptTest
  include BoardPage
  include CardPage

  test "User drags cards to other lists" do
    # Given a new board with a card
    visit_boards
    create_board("Board 1")
    card = create_card("My Card")

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
    Capybara.session_name = user_1
    visit_boards
    create_board("Board 2")

    # And another user on the same board
    Capybara.session_name = user_2
    visit_board("Board 2")

    # When I create a card
    Capybara.session_name = user_1
    create_card("User 1 Card")

    # Then the other user sees it in realtime
    Capybara.session_name = user_2
    within lists.first do
      assert has_card?("User 1 Card")
    end
  end

  test "User moves a card while other users are on the same page" do
    # Given a new board with a card
    Capybara.session_name = user_1
    visit_boards
    create_board("Board 3")
    card = create_card("User 1 Card")

    # And another user on the same board
    Capybara.session_name = user_2
    visit_board("Board 3")

    # When I create a card and I move it
    Capybara.session_name = user_1
    card.drag_to cards_container_for_list(lists.third)

    # Then the other user sees it in realtime
    Capybara.session_name = user_2
    within lists.third do
      assert has_card?("User 1 Card")
    end
  end

  test "User archives a card while other users are on the board" do
    # Given a new board with a card
    Capybara.session_name = user_1
    visit_boards
    create_board("Board 3")
    card = create_card("User 1 Card")

    # And another user on the same board
    Capybara.session_name = user_2
    visit_board("Board 3")

    # When I archive that card
    Capybara.session_name = user_1
    show_card(card)
    archive_card

    # Then the other user sees it disappear in realtime
    Capybara.session_name = user_2
    refute has_card?("User 1 Card")
  end
end
