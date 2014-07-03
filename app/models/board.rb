class Board < ActiveRecord::Base
  after_create :add_sample_lists

  validates :title, presence: true

  has_many :lists

  def add_list!(title)
    lists.create(title: title)
  end

  private

  def add_sample_lists
    add_list! I18n.t('lists.list.todo')
    add_list! I18n.t('lists.list.doing')
    add_list! I18n.t('lists.list.review')
  end
end
