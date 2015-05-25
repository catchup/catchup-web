$(document).on "ready page:load", ->
  $("[data-ux-comments-inline-form]").hide()

  $("[data-ux-edit-comment]").click (event) ->
    $editButton = $(event.target)
    $editButton.siblings(
      "[data-ux-comment-body], [data-ux-comments-inline-form]"
    ).toggle()
    $editButton.toggle()

  $("[data-ux-cancel-comment]").click (event) ->
    $cancelButton = $(event.target)
    $form = $cancelButton.closest("[data-ux-comments-inline-form]").hide()
    $form.siblings(
      "[data-ux-comment-body], [data-ux-edit-comment]"
    ).toggle()
