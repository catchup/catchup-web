class User < ActiveRecord::Base
  validates :email, presence: true
  validates_email_format_of :email

  has_and_belongs_to_many :owned_boards,
                          join_table: "boards_owners",
                          class_name: "Board"

  def create_board(params)
    Board.create(params).tap { |b| b.add_owner(self) }
  end

  def update_with_auth_schema!(auth_schema)
    self.auth_token = auth_schema.credentials.token
    self.avatar_url = auth_schema.info.image
    self.email      = auth_schema.info.email
    self.nickname   = auth_schema.info.nickname
    self.save!
  end
end
