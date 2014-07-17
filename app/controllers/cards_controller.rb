class CardsController < ApplicationController
  def create
    @card = list.create_card(card_params)

    if @card.valid?
      card_html = render_to_string(@card)
      Pusher.trigger(
        "board_#{@card.list.board_id}",
        "new_card",
        id: @card.id, list_id: @card.list_id, html: card_html
      )
    else
      flash[:alert] = I18n.t("cards.create.error")
    end

    redirect_to list.board
  end

  def update
    @card = Card.find(params[:id])
    @card.move_to(
      list: card_params.fetch(:list_id),
      position: card_params.fetch(:position)
    )

    redirect_to list.board
  end

  private

  def list
    @list ||= List.find(card_params[:list_id])
  end

  def card_params
    params.require(:card).permit(:title, :list_id, :position)
  end
end
