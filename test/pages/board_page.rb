module BoardPage
  def cards_container_for_list(list)
    list.find("[data-role='cards-container']")
  end

  def create_card(title, on: nil)
    raise "Cards should be created into lists, missing :on option" if on.nil?

    list = on
    within list do
      fill_in "card[title]", with: title
      click_on "Create Card"
    end

    card(title)
  end

  def create_board(title)
    fill_in "board[title]", with: title
    click_on "Create Board"
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

  def visit_board(title)
    visit_boards
    click_on title
  end

  def visit_boards
    visit root_path
    click_on t("see_boards")
  end
end
