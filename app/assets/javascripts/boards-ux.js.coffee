$ ->
  $addCardButton = $('.js-add-card')
  $addCard       = $('.js-add-card-form-container')

  $boardSettingsButton = $('.js-board-settings')
  $boardSettings       = $('.js-board-settings-dialog-wrapper')

  new Catchup.Dialog($addCard).willOpenOnClickOf($addCardButton)
  new Catchup.Dialog($boardSettings).willOpenOnClickOf($boardSettingsButton)
