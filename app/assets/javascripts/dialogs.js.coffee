window.Catchup.Dialog = class Dialog
  constructor: ($element) ->
    @$element = $element.first()
    @$content = $element.clone().show().wrap('<div></div>').parent().html()

  willOpenOnClickOf: ($triggerer) ->
    $triggerer.click =>
      vex.open(
        content: @$content,
        contentCSS: {
          width: '64%', # 1200 -> 768
          height: @$element.css('height'),
          padding: '0'
        }
      )
