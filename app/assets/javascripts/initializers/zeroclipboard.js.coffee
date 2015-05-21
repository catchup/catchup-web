$ -> $("[data-clipboard-text]").each ->
  zeroClipboard = new ZeroClipboard(this)
  zeroClipboard.on "aftercopy", ->
    alert("copied!")
