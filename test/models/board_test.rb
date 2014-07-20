require "test_helper"

class BoardTest < ActiveSupport::TestCase
  test "creates cards on the first list" do
    board = Board.create(title: "a board")
    card  = board.create_card(title: "a card")

    first_list = board.lists.first
    assert first_list.cards.include?(card)
  end
end
