require "test_helper"
require "minitest/mock"

class CardMailSenderTest < ActionMailer::TestCase
  def setup
    @cool_feature = cards(:cool_feature)
    @cool_feature.stubs(:involved_users).returns([users(:antonio)])
  end

  test "sends an e-mail when a card is moved into another list" do
    @cool_feature.stubs(:changed_list?).returns(true)
    CardMailSender.card_moved(@cool_feature, nil)
    assert delivered_email?
  end

  test "does not send any e-mail when a card is not moved into another list" do
    @cool_feature.stubs(:changed_list?).returns(false)
    CardMailSender.card_moved(@cool_feature, nil)
    refute delivered_email?
  end
end
