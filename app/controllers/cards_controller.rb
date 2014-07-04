class CardsController < ApplicationController
  def create
    @card = list.create_card(card_params)

    flash[:alert] = I18n.t("cards.create.error") unless @card.valid?
    redirect_to @card.list.board
  end

  private

  def card_params
    params.require(:card).permit(:title)
  end

  def list
    board = Board.find(params[:board_id])

    board.lists.find(params[:list_id])
  end
end
