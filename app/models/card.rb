class Card < ActiveRecord::Base
  include RankedModel

  has_many :comments, -> { order(created_at: :desc) }
  belongs_to :list
  delegate :board, to: :list

  ranks :position, with_same: :list_id

  validates :title, presence: true

  def move_to(location)
    list_id  = location.fetch(:list, self.list_id)
    position = location.fetch(:position)

    update_attribute(:list_id, list_id)
    update_attribute(:position_position, position)
  end

  def post_comment(by:, with:)
    attributes = with.merge(user: by)
    comments.create(attributes)
  end
end
