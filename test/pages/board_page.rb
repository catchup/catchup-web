module BoardPage
  def cards_container_for_list(list)
    list.find("[data-role='cards-container']")
  end

  def create_card(title)
    click_on "+"
    fill_in "card[title]", with: title
    click_on t("cards.create.submit")

    card(title)
  end

  def create_board(title)
    fill_in "board[title]", with: title
    click_on t("boards.create.submit")
  end

  def card(title)
    find("[data-role='card']", text: title)
  end

  def has_card?(title)
    card(title)
    true
  rescue Capybara::ElementNotFound
    false
  end

  def show_card(card_container)
    click_on card_container.text
  end

  def lists
    all("[data-role='list']").to_a
  end

  def visit_board(title)
    visit_boards
    click_on title
  end

  def visit_boards
    visit boards_path
  end
end
