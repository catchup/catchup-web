require 'test_helper'

class BoardTest < ActionDispatch::IntegrationTest
  test 'User creates a boards with fixed columns' do
    visit root_url
    click_on t('see_boards')

    # When I create a new board
    click_on 'New Board'
    fill_in 'board[title]', with: 'My Board'
    click_on 'Create Board'

    # Then I see To Do, Doing and Review
    assert page.has_text? t('lists.list.todo')
    assert page.has_text? t('lists.list.doing')
    assert page.has_text? t('lists.list.review')

    # And they are in order
    assert in_order? t('lists.list.todo'), t('lists.list.doing')
    assert in_order? t('lists.list.doing'), t('lists.list.review')
  end
end
