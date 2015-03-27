$(document).on "ready page:load", ->
  $('.js-bip_board-title').bind("best_in_place:activate", ->
    $(this).find('form').addClass('board-title-form clearfix')
  )

  $('.js-bip_card-title').bind("best_in_place:activate", ->
    $(this).find('form').addClass('card-title-form clearfix')
  )

  $('.js-bip_comment-body').bind("best_in_place:activate", ->
    $form = $(this).find('form')
    $form.addClass('comment-text-form clearfix')
    $form.find('textarea').addClass('bip_comment-text')
  )
