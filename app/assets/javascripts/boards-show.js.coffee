$cardsContainer = $(".js-cards-container");

if $cardsContainer.length >= 1
  resizeElements = ->
    $cardsContainer.height($(window).height() - 220);

  $(document).ready(resizeElements);
  $(window).resize(resizeElements);
