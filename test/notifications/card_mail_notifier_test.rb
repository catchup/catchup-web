require "test_helper"
require "minitest/mock"

class CardMailNotifierTest < ActionMailer::TestCase
  test "sends an e-mail when a card is moved into another list" do
    cool_feature.stub(:changed_list?, true) do
      CardMailNotifier.card_moved(cool_feature, nil)
    end

    assert delivered_email?
  end

  test "does not send any e-mail when a card is not moved into another list" do
    cool_feature.stub(:changed_list?, false) do
      CardMailNotifier.card_moved(cool_feature, nil)
    end

    refute delivered_email?
  end

  private

  def cool_feature
    @cool_feature ||= cards(:cool_feature)
  end
end
