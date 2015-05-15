class NewBoardsController < ApplicationController
  def index
    @linked_boards = current_user.github_boards
    @new_boards = current_user.github_boards
  end
end
