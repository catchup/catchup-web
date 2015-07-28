$(document).on "ready page:load", ->
  $("[data-ux-create-card-section]").hide()

  $("[data-ux-new-card]").on "click", (event) ->
    event.preventDefault()
    $("[data-ux-create-card-section]").show()

    top = $("#new").offset().top
    headerHeight = $("[data-ux-header]").outerHeight()
    $("html, body").animate(
      { scrollTop: top - headerHeight },
      => window.location.hash = $(this).attr("href")
    )

  $("[data-ux-cancel-create-card]").on "click", (event) ->
    event.preventDefault()
    $("[data-ux-create-card-section]").hide()


$(document).on "ready page:load", ->
  $("[data-ux-board-settings-section]").hide()

  $("[data-ux-open-board-settings], [data-ux-close-board-settings]").on "click", (event) ->
    event.preventDefault()
    $("[data-ux-board-settings-section]").toggle()
