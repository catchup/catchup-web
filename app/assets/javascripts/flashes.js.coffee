$(document).on "ready page:load", ->
  showDuration = 600
  hideDuration = 200

  # Show flashes all at once
  $('.js-flash-container').hide()
  $('body').animate({
    "margin-top": $('.js-flash-container').outerHeight()
  }, showDuration)
  $('.js-flash-container, .js-flash').toggle()
  $('.js-flash').slideDown(showDuration)

  # Dismiss a single flash on click
  $('.js-dismiss').click (event) ->
    $flash = $(event.target).closest('.js-flash')
    $('body').animate({
      "margin-top": $('.js-flash-container').outerHeight() - $flash.outerHeight()
    }, hideDuration)
    $flash.slideUp(hideDuration)
