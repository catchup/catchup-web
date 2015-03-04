class Card < ActiveRecord::Base
  include RankedModel

  scope :unarchived, -> { where(archived: false) }

  has_many :comments, -> { order(created_at: :desc) }
  belongs_to :list
  delegate :board, to: :list

  ranks :position, with_same: :list_id

  validates :title, presence: true

  def move_to(list_id: nil, position:)
    changed_list! if Integer(list_id) != self.list_id

    update_attribute(:list_id, list_id) if list_id
    update_attribute(:position_position, position)
  end

  def changed_list?
    @changed_list == true
  end

  def changed_list!
    @changed_list = true
  end

  def post_comment(by:, with:)
    attributes = with.merge(user: by)
    comments.create(attributes)
  end

  def archive
    update_attribute(:archived, true)
  end

  def involved_users
    board.subscribers
  end

  def previewing!
    update_attribute(:previewing, true)
  end

  def previewed!(url)
    update_attributes(previewing: false, preview_url: url)
  end

  def previewed?
    !previewing? && preview_url?
  end

  def branch_tarball
    uri = URI(board.repository_url)
    uri.path = "/archive/#{branch_name}.tar.gz"
    uri.to_s
  end
end
