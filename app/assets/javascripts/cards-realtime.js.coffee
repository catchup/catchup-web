$(document).on "ready page:load", ->
  $card = $("[data-role='single-card']")
  return if $card.length == 0

  board_id = $card.data("board-id")
  channel = new Pusher("4e4a38fa3b508541cbbd").subscribe("board_#{board_id}")
  channel.bind 'preview_card', (card) ->
    location.reload()
