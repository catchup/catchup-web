$(document).on "ready page:load", ->
  BOARD_CONTAINER          = "[data-role='board']"
  CARDS_CONTAINER_SELECTOR = "[data-role='cards-container']"

  $board = $(BOARD_CONTAINER)
  if $board.length == 1
    board_id = $board.data('board-id')
    channel = new Pusher("4e4a38fa3b508541cbbd").subscribe("board_#{board_id}")

    channel.bind 'new_card', (card) ->
      $container = $(CARDS_CONTAINER_SELECTOR).filter("[data-list-id='#{card.list_id}']")
      $container.prepend(card.html)
      $(document).trigger('new_card')
