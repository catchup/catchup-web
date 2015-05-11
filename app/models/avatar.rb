class Avatar
  include ActiveModel::Model

  attr_reader :size
  attr_reader :url

  def initialize(size, url)
    @size = size
    @url = url
  end
end
