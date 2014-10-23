require "test_helper"
require "mocha/mini_test"

class CardMailerTest < ActionMailer::TestCase
  def setup
    @irrelevant_card = cards(:cool_feature)
    @involved_users  = [users(:antonio)]

    @irrelevant_card.stubs(:involved_users).returns(@involved_users)
  end

  test "new_card is sent to involved users only" do
    email = CardMailer.new_card(@irrelevant_card)
    assert sent_to_involved_users?(email)
  end

  test "card_moved is sent to involved users only" do
    email = CardMailer.card_moved(@irrelevant_card)
    assert sent_to_involved_users?(email)
  end

  test "card_archived is sent to involved users only" do
    email = CardMailer.card_archived(@irrelevant_card)
    assert sent_to_involved_users?(email)
  end

  private

  def sent_to_involved_users?(email)
    @involved_users.map(&:email) == email.to
  end
end
