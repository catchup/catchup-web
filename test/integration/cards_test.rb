require 'test_helper'
require 'pages/board_page'

class CardsTest < ActionDispatch::IntegrationTest
  include BoardPage

  setup do
    Capybara.current_driver = Capybara.javascript_driver

    visit root_path
    click_on t('see_boards')
  end

  teardown do
    Capybara.use_default_driver
  end

  test 'User drags cards to other lists' do
    # Given a new board with a card
    create_board('a board')
    card = create_card(
      'My Card',
      on: lists.first
    )

    # When I drag a card to another list
    another_list = lists.second
    card.drag_to cards_container_for_list(another_list)

    # Then that card should stick to the new list
    within another_list do
      assert has_card?('My Card')
    end

    # And its position should be persisted
    # refresh
    # within another_list do
    #   assert has_card?('My Card')
    # end
  end
end
