class NewBoardsController < ApplicationController
  skip_before_action :authenticate

  def index
    @boards = [
      board("exalted/dotfiles", [ali]),
      board("catchup/catchup-web", [antonio, ali, antonio, ali, ali, antonio]),
      board("as-cii/terminal-emojify", [antonio, ali])
    ]
  end

  private

  def board(title, collaborators)
    Board.new do |board|
      board.title = title
      board.collaborators = collaborators
    end
  end

  def ali
    user("314398")
  end

  def antonio
    user("482957")
  end

  def user(id)
    User.new do |user|
      user.avatar_url = avatar_url(id)
    end
  end

  def avatar_url(id)
    "https://avatars3.githubusercontent.com/u/#{id}?v=3&s=460"
  end
end
