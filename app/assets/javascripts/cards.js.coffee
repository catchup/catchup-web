$(document).on "ready page:load", ->
  CARDS_CONTAINER_SELECTOR = "[data-role='cards-container']"
  CARD_UPDATE_FORM         = "[data-role='card-update-form']"

  $(CARDS_CONTAINER_SELECTOR).sortable(
    connectWith: CARDS_CONTAINER_SELECTOR,
    stop: (event, ui) ->
      $list  = ui.item.parent()
      $card  = ui.item
      $update_form = $card.find(CARD_UPDATE_FORM)

      list_id  = $list.data("list-id")
      card_id  = $card.data("card-id")
      position = $card.index()

      $update_form.find("#card_list_id").val(list_id)
      $update_form.find("#card_position").val(position)
      $update_form.submit()
  )
