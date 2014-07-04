class CardsController < ApplicationController
  def create
    @card = list.cards.new(card_params)

    flash[:alert] = I18n.t('cards.create.error') unless @card.save
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
