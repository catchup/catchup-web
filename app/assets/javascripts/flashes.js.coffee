$(document).on "ready page:load", ->

  $('.flash').slideDown(800)

  $('.close-flash').click (event) ->
    $flash = $(event.target).closest('.flash')
    $flash.slideUp(200)
