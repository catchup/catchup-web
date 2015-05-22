$(document).on "ready page:load", -> $("[data-clipboard-text]").each ->
  zeroClipboard = new ZeroClipboard(this)
  zeroClipboard.on "ready", -> zeroClipboard.on "aftercopy", ->
    alert "Yeeeeessss!"

$(document).on "page:before-unload", -> ZeroClipboard.destroy()
