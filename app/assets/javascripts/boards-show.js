(function() {
  var $cardsContainer = $('.js-cards-container');


  function resizeElements() {
    $cardsContainer.height($(window).height()-220);
  }

  $(document).ready(resizeElements);
  $(window).resize(resizeElements);

})();
