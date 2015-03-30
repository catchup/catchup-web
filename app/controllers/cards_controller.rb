class CardsController < ApplicationController
  def create
    @card = board.create_card(card_params)

    if @card.valid?
      card_html = render_to_string(@card)
      CardObserver.publish(:card_created, @card, current_user, card_html)
    else
      flash[:alert] = I18n.t("cards.create.error")
    end

    redirect_to board
  end

  def show
    @card = board.cards.find(params[:id])
  end

  def move
    @card = board.cards.find(params[:id])
    @card.move_to(move_params)

    CardObserver.publish(:card_moved, @card, current_user, move_params)

    render nothing: true
  end

  def archive
    @card = board.cards.find(params[:id])
    @card.archive

    CardObserver.publish(:card_archived, @card, current_user)

    redirect_to [@card.board, @card]
  end

  def update
    card = board.cards.find(params[:id])
    card.update_attributes(card_params)

    respond_to do |format|
      format.json { respond_with_bip(card) }
    end
  end

  private

  def board
    @board ||= Board.find(params[:board_id])
  end

  def card_params
    params.require(:card).permit(:title, :branch_tarball, :app_name)
  end

  def move_params
    params.require(:card).permit(:list_id, :position).symbolize_keys
  end
end
