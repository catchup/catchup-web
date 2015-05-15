class User < ActiveRecord::Base
  UnauthorizedException = Class.new(StandardError)

  validates :email, presence: true
  validates_email_format_of :email

  has_and_belongs_to_many :owned_boards,
                          join_table: "boards_owners",
                          class_name: "Board"

  def create_board(title)
    raise UnauthorizedException unless github_repositories_full_names.include?(title)

    Board.new(title: title)
  end

  def find_board(id)
    board = Board.find(id)
    raise UnauthorizedException unless github_repositories_full_names.include?(board.title)

    board
  end

  def github_linked_boards
    @github_linked_boards ||= Board.where(title: github_repositories_full_names)
  end

  def github_new_boards
    new_boards = github_repositories_full_names - github_linked_boards.map(&:title)

    new_boards.map { |repo_full_name| Board.new(title: repo_full_name) }
  end

  def update_with_auth_schema!(auth_schema)
    self.auth_token = auth_schema.credentials.token
    self.avatar_url = auth_schema.info.image
    self.email      = auth_schema.info.email
    self.nickname   = auth_schema.info.nickname
    self.save!
  end

  private

  def github_repositories_full_names
    github.repositories(nil, type: :public).map(&:full_name)
  end

  def github
    @github_user ||= Octokit::Client.new(access_token: self.auth_token)
  end
end
