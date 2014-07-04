require 'test_helper'

class ListTest < ActiveSupport::TestCase
  test 'puts latest created cards first' do
    list   = lists(:sample)
    first  = list.create_card(title: 'card 1')
    second = list.create_card(title: 'card 2')

    assert_equal [second, first], list.cards
  end
end
