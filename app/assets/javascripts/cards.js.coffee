$ ->
  CARDS_CONTAINER_CLASS = '[data-role="cards-container"]'

  $(CARDS_CONTAINER_CLASS).sortable(
    connectWith: CARDS_CONTAINER_CLASS
  )
