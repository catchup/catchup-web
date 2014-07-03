class Board < ActiveRecord::Base
  validates :title, presence: true
end
