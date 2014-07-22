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
      position: 0
    )

    assert_equal third, list.cards.reload.first
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
      list: list_2.id,
      position: 2
    )

    assert_not list_1.cards.reload.include?(first)
    assert_equal first, list_2.cards.reload.second
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
end
