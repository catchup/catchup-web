require "test_helper"

class CardMailSenderTest < ActionMailer::TestCase
  def setup
    @cool_feature = cards(:cool_feature)
  end

  test "sends an e-mail when a card is moved into another list" do
    @cool_feature.stubs(:involved_users).returns([users(:antonio), users(:ali)])
    @cool_feature.stubs(:changed_list?).returns(true)

    CardMailSender.card_moved(@cool_feature, originated_by: users(:antonio))

    assert delivered_email?
  end

  test "does not send any e-mail when a card is not moved into another list" do
    @cool_feature.stubs(:involved_users).returns([users(:antonio), users(:ali)])
    @cool_feature.stubs(:changed_list?).returns(false)

    CardMailSender.card_moved(@cool_feature, originated_by: users(:antonio))

    refute delivered_email?
  end

  test "does not send an e-mail if a card is not moved into another list" do
    @cool_feature.stubs(:involved_users).returns([users(:antonio), users(:ali)])
    @cool_feature.stubs(:changed_list?).returns(false)

    CardMailSender.card_moved(@cool_feature, originated_by: users(:antonio))

    refute delivered_email?
  end

  test "does not send an e-mail if there wouldn't be any user to send it to" do
    @cool_feature.stubs(:involved_users).returns([users(:antonio)])
    @cool_feature.stubs(:changed_list?).returns(true)

    CardMailSender.card_moved(@cool_feature, originated_by: users(:antonio))

    refute delivered_email?
  end
end
