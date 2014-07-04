module BoardPage
  def cards_container_for_list(list)
    list.find("[data-role='cards-container']")
  end

  def create_card(title, on: nil)
    raise 'Cards should be created into lists, missing :on option' if on.nil?

    list = on
    within list do
      fill_in 'card[title]', with: title
      click_on 'Create Card'
    end

    card(title)
  end

  def create_board(title)
    click_on 'New Board'
    fill_in 'board[title]', with: title
    click_on 'Create Board'
  end

  def card(title)
    find("[data-role='card']", text: title)
  end

  def has_card?(title)
    card(title) != nil
  end

  def lists
    all("[data-role='list']").to_a
  end
end