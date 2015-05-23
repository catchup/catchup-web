class Card < ActiveRecord::Base
  after_create :assign_branch_name

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
    uri = build_repository_uri
    uri.path += "archive/#{branch_name}.tar.gz"
    uri.to_s
  end

  def compare_url(card_url)
    pr_body = "[View on catchup](#{card_url})"
    pr_body += "\n\n#{description}" if description.present?

    uri = build_repository_uri
    uri.path += "compare/#{branch_name}"
    uri.query = "expand=1&title=#{title}&body=#{pr_body}"
    uri.to_s
  end

  private

  WORDS_BLACKLIST = ["after", "although", "and", "as", "because", "before", "but", "even", "for", "if", "in", "nor", "only", "of", "or", "since", "so", "than", "that", "then", "though", "till", "unless", "until", "when", "whenever", "where", "whereas", "wherever", "while", "yet"]

  def assign_branch_name
    words = title.downcase.gsub(/[[:punct:]]/, "").split
    words -= WORDS_BLACKLIST
    slug = words.take(5).join("-")

    self.branch_name = "catchup/#{id}-#{slug}"
    save!
  end

  def build_repository_uri
    uri = URI(board.repository_url)
    uri.path += "/" unless uri.path.ends_with?("/")
    uri
  end
end
