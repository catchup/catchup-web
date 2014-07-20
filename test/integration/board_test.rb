require 'test_helper'
require 'pages/board_page'

class BoardTest < ActionDispatch::IntegrationTest
  include BoardPage

  setup do
    visit_boards
  end

  test 'User creates a boards with fixed lists' do
    # When I create a new board
    create_board('a board')

    # Then I see To Do, Doing and Review
    assert page.has_text? t('lists.list.todo')
    assert page.has_text? t('lists.list.doing')
    assert page.has_text? t('lists.list.review')

    # And they are in order
    assert in_order? t('lists.list.todo'), t('lists.list.doing')
    assert in_order? t('lists.list.doing'), t('lists.list.review')
  end
end
