noticeDisplayInProgress = false

$(document).on "ready page:load", ->
  $clipboardNotice = $("#clipboard-notice")
  $clipboardNotice.hide()

  $("[data-clipboard-text]").each -> new ZeroClipboard(this)

  ZeroClipboard.on "ready", ->
    ZeroClipboard.on "aftercopy", ->
      return if noticeDisplayInProgress

      noticeDisplayInProgress = true
      $clipboardNotice.show()
      setTimeout(->
        $clipboardNotice.hide()
        noticeDisplayInProgress = false
      , 500)

$(document).on "page:before-unload", -> ZeroClipboard.destroy()
