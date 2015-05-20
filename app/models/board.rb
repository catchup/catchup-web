class Board < ActiveRecord::Base
  after_create :add_sample_lists

  validates :title, presence: true

  has_many :lists, -> { order(position: :asc) }
  has_many :cards, through: :lists
  has_and_belongs_to_many :subscribers,
                          join_table: "boards_subscriptions",
                          class_name: "User"
  has_and_belongs_to_many :owners,
                          join_table: "boards_owners",
                          class_name: "User"

  attr_accessor :description

  def add_list!(params)
    lists.create(params)
  end

  def create_card(params)
    lists.first.create_card(params)
  end

  def toggle_subscription_for(user)
    if has_subscriber?(user)
      subscribers.delete(user)
    else
      subscribers << user
    end
  end

  def has_subscriber?(user)
    subscribers.where(id: user.id).exists?
  end

  def add_owner(user)
    owners << user
  end

  def repository_url
    "https://github.com/#{self.title}"
  end

  private

  def add_sample_lists
    add_list!(
      title: I18n.t('lists.list.todo'),
      position: 0
    )

    add_list!(
      title: I18n.t('lists.list.doing'),
      position: 1
    )

    add_list!(
      title: I18n.t('lists.list.review'),
      position: 2
    )
  end
end
