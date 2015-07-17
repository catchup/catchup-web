class ApplinksController < ApplicationController
  def index
    board_id = params[:board_id]

    @api_key = params[:api_key]
    @heroku_apps = Heroku::Application.all(@api_key)
    @board = Board.find(board_id)
  end

  def create
    board = Board.find(params[:board_id])

    board.update_attributes(
      app_name: params[:app_name], heroku_api_key: params[:api_key]
    )

    redirect_to board
  end
end
