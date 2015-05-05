$(document).on "ready page:load", ->
  showDuration = 600
  hideDuration = 200

  ui = {
    'container': '[data-ux-flash-container]',
    'flash'    : '[data-ux-flash]',
    'dismiss'  : '[data-ux-flash-dismiss]'
  }

  # Show flashes all at once
  $(ui['container']).hide()
  $('body').animate({
    "margin-top": $(ui['container']).outerHeight()
  }, showDuration)
  $("#{ui['container']}, #{ui['flash']}").toggle()
  $(ui['flash']).slideDown(showDuration)

  # Dismiss a single flash on click
  $(ui['dismiss']).click (event) ->
    $flash = $(event.target).closest(ui['flash'])
    $('body').animate({
      "margin-top": $(ui['container']).outerHeight() - $flash.outerHeight()
    }, hideDuration)
    $flash.slideUp(hideDuration)
