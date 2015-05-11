$(document).on "ready page:load", ->
  $('[data-ux-flash-dismiss]').click (event) ->
    $(event.target).closest('[data-ux-flash]').hide()
