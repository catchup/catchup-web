$(document).on "ready page:load", ->
  $("body").css({
    "margin-top": $("[data-ux-header]").outerHeight()
  })
