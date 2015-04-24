class User < ActiveRecord::Base
  validates :email, presence: true
  validates_email_format_of :email

  has_and_belongs_to_many :owned_boards,
                          join_table: "boards_owners",
                          class_name: "Board"

  def create_board(params)
    Board.create(params).tap { |b| b.add_owner(self) }
  end

  def self.authenticate(provider, uid)
    find_or_initialize_by(auth_provider: provider, auth_uid: uid)
  end
end
