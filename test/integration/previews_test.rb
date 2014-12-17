require "test_helper"
require "integration/javascript_test"
require "pages/board_page"
require "pages/card_page"

class PreviewsTest < ActionDispatch::IntegrationTest
  include BoardPage
  include CardPage

  def setup
    @any_preview_url = "irrelevant"
  end

  test "User waits for a preview" do
    # Given a board with a card
    sign_in users(:antonio)
    create_board("a board")
    card = create_card("My Card")

    # When I am on a card that is being previewed
    Card.last.previewing!
    show_card(card)

    # Then an activity indicator spinner becomes visible
    assert preview_spinner_visibile?

    # When the preview finishes
    Card.last.previewed!(@any_preview_url)
    CardObserver.publish(:card_previewed, Card.last, Card.last.preview_url)
    refresh

    # Then the activity indicator spinner hides itself
    refute preview_spinner_visibile?

    # And the url is displayed instead
    assert has_preview_url?(@any_preview_url)
  end
end
