$(document).on "ready page:load", ->
  $("[data-ux-create-board]").on "click", (event) ->
    event.preventDefault()

    top = $("#create-board-section").offset().top
    headerHeight = $("[data-ux-header]").outerHeight()
    $("html, body").animate(
      { scrollTop: top - headerHeight },
      => window.location.hash = $(this).attr("href")
    )
