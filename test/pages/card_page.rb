module CardPage
  def archive_card
    click_on t("cards.archive.submit")
  end

  def can_comment?
    has_button? t("comments.create.submit")
  end

  def leave_comment(text)
    fill_in "comment_text", with: text
    click_on t("comments.create.submit")
  end

  def has_comment?(text)
    page.has_text? text
  end

  def has_preview_spinner?
    page.has_selector?("div.spinner")
  end

  def has_no_preview_spinner?
    page.has_no_selector?("div.spinner")
  end

  def has_preview_url?(url)
    page.has_link? url
  end
end