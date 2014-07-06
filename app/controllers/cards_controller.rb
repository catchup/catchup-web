class CardsController < ApplicationController
  def create
    @card = list.create_card(card_params)

    flash[:alert] = I18n.t("cards.create.error") unless @card.valid?
    redirect_to list.board
  end

  def update
    @card = list.cards.find(params[:id])
    @card.move_to(
      list: card_params.fetch(:list_id),
      position: card_params.fetch(:position)
    )

    redirect_to list.board
  end

  private

  def card_params
    params.require(:card).permit(:title, :list_id, :position)
  end

  def list
    board = Board.find(params[:board_id])

    @list ||= board.lists.find(params[:list_id])
  end
end
