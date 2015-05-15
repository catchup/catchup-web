class NewBoardsController < ApplicationController
  def index
    @linked_boards = current_user.github_linked_boards
    @new_boards = current_user.github_new_boards
  end
end
