$(document).on "ready page:load", ->
  $("[data-clipboard-text]").each -> new ZeroClipboard(this)

  ZeroClipboard.on "ready", -> ZeroClipboard.on "aftercopy", ->
    alert "Yeeeeessss!"

$(document).on "page:before-unload", -> ZeroClipboard.destroy()
