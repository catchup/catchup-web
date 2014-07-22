class Comment < ActiveRecord::Base
  belongs_to :card
  belongs_to :user

  validates :text, presence: true
  validates :user, presence: true
end
