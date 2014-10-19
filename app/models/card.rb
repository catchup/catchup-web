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

  def app_name
    "catchup-web"
  end

  def branch_tarball
    "https://github.com/catchup/catchup-web/archive/whatever.tar.gz"
  end
end
