$ -> $("[data-clipboard-text]").each ->
  zeroClipboard = new ZeroClipboard(@)
  zeroClipboard.on "aftercopy", ->
    alert("copied!")
