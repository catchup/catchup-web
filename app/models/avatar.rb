class Avatar
  include ActiveModel::Model

  attr_reader :size
  attr_reader :url

  def initialize(size, url)
    @size = size
    @url = url
  end

  def self.small(*users)
    users.map { |e| new(:small, e.avatar_url) }
  end

  def self.tiny(*users)
    users.map { |e| new(:tiny, e.avatar_url) }
  end

  def self.large(*users)
    users.map { |e| new(:large, e.avatar_url) }
  end
end
