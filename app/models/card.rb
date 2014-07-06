class Card < ActiveRecord::Base
  include RankedModel

  belongs_to :list
  ranks :position, with_same: :list_id

  validates :title, presence: true

  def move_to(location)
    list_id  = location.fetch(:list)
    position = location.fetch(:position)

    update_attribute(:list_id, list_id)
    update_attribute(:position_position, position)
  end
end
