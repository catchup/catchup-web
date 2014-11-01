require "test_helper"
require "integration/javascript_test"
require "pages/board_page"
require "pages/card_page"

class PreviewsTest < JavascriptTest
  include BoardPage
  include CardPage

  def setup
    @any_preview_url = "irrelevant"
  end

  test "User waits for a preview" do
    # Given a board with a card
    visit_boards
    create_board("a board")
    card = create_card("My Card")

    # When I am on a card that is being previewed

    # TODO: this smells a bit. Acceptance tests should not really deal with
    # models...
    Card.last.previewing!
    show_card(card)

    # Then a "wait" message is displayed
    assert has_preview_wait_message?

    # When the preview finishes
    Card.last.previewed!(@any_preview_url)
    sleep 2
    CardObserver.publish(:card_previewed, Card.last, Card.last.preview_url)

    # Then the wait message disappears
    refute has_preview_wait_message?

    # And the url is displayed instead
    assert has_preview_url?(@any_preview_url)
  end
end
