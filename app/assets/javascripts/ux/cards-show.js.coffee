$(document).on "ready page:load", ->
  $("[data-ux-edit-card-section]").hide()

  $("[data-ux-edit-card], [data-ux-cancel-update-card]").on "click", (event) ->
    event.preventDefault()

    $("[data-ux-edit-card-section]").toggle()
    $("[data-ux-card-header-section]").toggle()
    $("[data-ux-comment-form-container]").toggle()
