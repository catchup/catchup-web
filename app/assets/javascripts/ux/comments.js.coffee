$(document).on "ready page:load", ->
  $("[data-ux-comments-inline-form]").hide()

  $("[data-ux-edit-comment]").click (event) ->
    $body = $(event.target).closest("[data-ux-comment-body]")
    $body.hide()
    $body.siblings("[data-ux-comments-inline-form]").show()

  $("[data-ux-cancel-comment]").click (event) ->
    $form = $(event.target).closest("[data-ux-comments-inline-form]")
    $form.hide()
    $form.siblings("[data-ux-comment-body]").show()
