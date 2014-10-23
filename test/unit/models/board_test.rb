require "test_helper"

class BoardTest < ActiveSupport::TestCase
  test "creates cards on the first list" do
    board = boards(:development)
    card  = board.create_card(title: "a card")

    first_list = board.lists.first
    assert first_list.cards.include?(card)
  end

  test "subscribes users to a board if not subscribed previously" do
    board = boards(:development)

    board.toggle_subscription_for users(:antonio)
    board.toggle_subscription_for users(:ali)

    assert board.has_subscriber? users(:antonio)
    assert board.has_subscriber? users(:ali)
  end

  test "unsubscribes a user if toggles his subscription twice" do
    board = boards(:development)

    board.toggle_subscription_for users(:antonio)
    board.toggle_subscription_for users(:ali)
    board.toggle_subscription_for users(:ali)

    assert board.has_subscriber? users(:antonio)
    refute board.has_subscriber? users(:ali)
  end
end
