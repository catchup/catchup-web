class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def create
    @board = Board.new(board_params)

    if @board.save
      redirect_to @board
    else
      redirect_to(
        boards_path,
        alert: t("boards.create.error")
      )
    end
  end

  def toggle_subscription
    board = Board.find(params[:id])
    board.toggle_subscription_for(current_user)

    redirect_to board
  end

  def update
    board = Board.find(params[:id])
    board.update_attributes(board_params)

    redirect_to board
  end

  private

  def board_params
    params.require(:board).permit(:title, :heroku_api_key, :app_name)
  end
end
