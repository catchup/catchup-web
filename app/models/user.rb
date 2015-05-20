class User < ActiveRecord::Base
  UnauthorizedException = Class.new(StandardError)

  validates :email, presence: true
  validates_email_format_of :email

  has_and_belongs_to_many :owned_boards,
                          join_table: "boards_owners",
                          class_name: "Board"

  def create_board(title)
    raise UnauthorizedException unless github_repositories.map(&:full_name).include?(title)

    Board.new(title: title)
  end

  def find_board(id)
    board = Board.find(id)
    repo  = github_repositories.detect { |e| e.full_name == board.title }

    raise UnauthorizedException if repo.nil?

    board.description = repo.description
    board
  end

  def github_linked_boards
    @github_linked_boards ||= github_repositories.map do |repo|
      board = Board.find_by(title: repo.full_name)
      next if board.nil?

      board.description = repo.description
      board
    end.compact
  end

  def github_new_boards
    @github_new_boards ||= github_repositories.map do |repo|
      next if Board.find_by(title: repo.full_name).present?

      Board.new(title: repo.full_name, description: repo.description)
    end.compact
  end

  def update_with_auth_schema!(auth_schema)
    self.auth_token = auth_schema.credentials.token
    self.avatar_url = auth_schema.info.image
    self.email      = auth_schema.info.email
    self.nickname   = auth_schema.info.nickname
    self.save!
  end

  private

  def github_repositories
    @github_repositories ||= github.repositories(nil, type: :public)
  end

  def github
    @github_user ||= Octokit::Client.new(access_token: self.auth_token)
  end
end
