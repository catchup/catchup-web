require "test_helper"

class CardMailerTest < ActionMailer::TestCase
  test "new_card is sent to all the users" do
    email = CardMailer.new_card cards(:cool_feature)

    assert sent_to_everyone?(email)
  end

  test "card_moved is sent to all the users" do
    email = CardMailer.card_moved cards(:cool_feature)

    assert sent_to_everyone?(email)
  end
end
