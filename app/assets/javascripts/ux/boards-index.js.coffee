$(document).on "ready page:load", ->
  $("[data-ux-new-board]").on "click", (event) ->
    event.preventDefault()

    top = $("#new").offset().top
    headerHeight = $("[data-ux-header]").outerHeight()
    $("html, body").animate(
      { scrollTop: top - headerHeight },
      => window.location.hash = $(this).attr("href")
    )
