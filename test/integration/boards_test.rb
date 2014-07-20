require "test_helper"
require "pages/board_page"

class BoardsTest < ActionDispatch::IntegrationTest
  include BoardPage

  setup do
    visit_boards
  end

  test "User creates a boards with fixed lists" do
    # When I create a new board
    create_board("a board")

    # Then I see To Do, Doing and Review
    assert page.has_text? t("lists.list.todo")
    assert page.has_text? t("lists.list.doing")
    assert page.has_text? t("lists.list.review")

    # And they are in order
    assert in_order? t("lists.list.todo"), t("lists.list.doing")
    assert in_order? t("lists.list.doing"), t("lists.list.review")
  end

  test "User creates a new card" do
    # Given a board
    create_board("a board")

    # When I create a new card
    create_card("My Card")

    # Then it should appear on the first list
    within lists.first do
      assert has_card?("My Card")
    end
  end
end
