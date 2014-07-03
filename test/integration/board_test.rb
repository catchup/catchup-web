require 'test_helper'

class BoardTest < ActionDispatch::IntegrationTest
  test 'User creates a boards with fixed columns' do
    visit root_url
    click_on t('see_boards')

    click_on 'New Board'
    fill_in 'board[title]', with: 'My Board'
    click_on 'Create Board'

    assert page.has_text? t('lists.list.todo')
    assert page.has_text? t('lists.list.doing')
    assert page.has_text? t('lists.list.review')
  end
end
