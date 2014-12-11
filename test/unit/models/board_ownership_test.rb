require "test_helper"

class BoardOwnershipTest < ActiveSupport::TestCase
  test "added owners" do
    board = boards(:development)
    owner = users(:antonio)
    board.add_owner(owner)
    assert owner.owned_boards.include?(board)
  end

  test "board creators" do
    creator = users(:antonio)
    board = creator.create_board(title: "any title")
    assert creator.owned_boards.include?(board)
  end

  test "other users" do
    assert_equal [], User.all.sample.owned_boards
  end
end
