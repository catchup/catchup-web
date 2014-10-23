require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test 'move into the same list' do
    # TODO: extract this out
    list = List.create(title: 'whatever')
    list.create_card(title: 'card 1')
    list.create_card(title: 'card 2')
    list.create_card(title: 'card 3')

    third = list.cards.third

    third.move_to(
      list_id: list.id,
      position: 0
    )

    assert_equal third, list.cards.reload.first
    refute third.changed_list?
  end

  test 'move into another list' do
    # TODO: extract this out
    list_1 = List.create(title: 'list 1')
    list_2 = List.create(title: 'list 2')
    list_1.create_card(title: 'card 1')
    list_1.create_card(title: 'card 2')
    list_2.create_card(title: 'card 3')

    first = list_1.cards.first

    first.move_to(
      list_id: list_2.id,
      position: 2
    )

    assert_not list_1.cards.reload.include?(first)
    assert_equal first, list_2.cards.reload.second
    assert first.changed_list?
  end

  test "posts a comment on the card" do
    card = cards(:cool_feature)

    comment = card.post_comment(
      by: users(:antonio),
      with: { text: "Hello, world!" }
    )

    assert card.comments.reload.include?(comment)
    assert_equal "Hello, world!", comment.text
    assert_equal users(:antonio), comment.user
  end

  test "archives the card" do
    card = cards(:cool_feature)
    card.archive

    unarchived_cards = card.list.cards.unarchived.reload
    assert card.archived?
    refute unarchived_cards.include?(card)
  end

  test "involved users are the same as board ones" do
    board = stub(subscribers: [stub, stub])
    card  = cards(:cool_feature)
    card.stubs(:board).returns(board)

    assert_equal board.subscribers, card.involved_users
  end
end
