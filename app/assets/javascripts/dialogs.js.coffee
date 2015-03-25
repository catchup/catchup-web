window.Catchup.Dialog = class Dialog
  constructor: ($element) ->
    @$element = $element.first()
    @$content = $element.clone().addClass('dialog').show()

  willOpenOnClickOf: ($triggerer) ->
    $triggerer.click (event) =>
      event.preventDefault()

      vex.open(
        content: @$content
        afterOpen: ($vexContent) ->
          height = $('.dialog').css('height')
          $vexContent.css('height', height)
        contentCSS: {
          width: '64%', # 1200 -> 768
          padding: '0'
        }
      )
