class Card < ActiveRecord::Base
  belongs_to :list

  validates :title, presence: true
end
