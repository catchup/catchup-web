$(document).on "ready page:load", ->
  BOARD_SELECTOR           = "[data-role='board']"
  CARD_SELECTOR            = "[data-role='card']"
  CARDS_CONTAINER_SELECTOR = "[data-role='cards-container']"

  $board = $(BOARD_SELECTOR)
  if $board.length == 1
    board_id = $board.data('board-id')
    channel = new Pusher("4e4a38fa3b508541cbbd").subscribe("board_#{board_id}")

    channel.bind 'new_card', (card) ->
      $container = $(CARDS_CONTAINER_SELECTOR).filter("[data-list-id='#{card.list_id}']")
      $container.prepend(card.html)
      $(document).trigger('new_card')

    channel.bind 'move_card', (card) ->
      MOVED_CARD_SELECTOR = "[data-card-id='#{card.id}']"
      $container = $(CARDS_CONTAINER_SELECTOR).filter("[data-list-id='#{card.list_id}']")
      other_client_moved = $container.find(MOVED_CARD_SELECTOR).index() != parseInt(card.position)

      if other_client_moved
        $card = $(CARD_SELECTOR).filter(MOVED_CARD_SELECTOR)
        $card.remove()
        $cardBelow = $container.children(CARD_SELECTOR)[card.position]
        if $cardBelow
          $card.insertBefore($cardBelow)
        else
          $container.append($card)

    channel.bind 'archive_card', (card) ->
      ARCHIVED_CARD_SELECTOR = "[data-card-id='#{card.id}']"
      $(ARCHIVED_CARD_SELECTOR).remove()
