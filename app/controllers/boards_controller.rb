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

  private

  def board_params
    params.require(:board).permit(:title)
  end
end
