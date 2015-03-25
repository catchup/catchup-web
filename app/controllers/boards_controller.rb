class BoardsController < ApplicationController
  def index
    @boards = current_user.owned_boards
  end

  def show
    @board = current_user.owned_boards.find(params[:id])
  end

  def create
    @board = current_user.create_board(board_params)

    if @board.save
      redirect_to @board
    else
      redirect_to boards_path, alert: t("boards.create.error")
    end
  end

  def toggle_subscription
    board = current_user.owned_boards.find(params[:id])
    board.toggle_subscription_for(current_user)

    redirect_to board
  end

  def update
    board = current_user.owned_boards.find(params[:id])
    board.update_attributes(board_params)

    respond_to do |format|
      format.html { redirect_to board }
      format.json { respond_with_bip(board) }
    end
  end

  private

  def board_params
    params.require(:board)
          .permit(:title, :heroku_api_key, :app_name, :repository_url)
  end
end
