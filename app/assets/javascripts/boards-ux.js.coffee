$ ->
  $newCardForm   = $('.js-add-card-form-container')
  $addCardButton = $('.js-add-card')

  new Catchup.Dialog($newCardForm).willOpenOnClickOf($addCardButton)
