require 'test_helper'

class ListTest < ActiveSupport::TestCase
  test 'puts latest created cards first' do
    list   = List.create(title: 'whatever')
    first  = list.create_card(title: 'card 1')
    second = list.create_card(title: 'card 2')
    third  = list.create_card(title: 'card 3')

    assert_equal [third, second, first], list.cards
  end
end
