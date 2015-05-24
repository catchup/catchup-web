module ApplicationHelper
  def site_markdown(text)
    markdown = Redcarpet::Markdown.new(
      CatchupMarkdownRenderer,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      underline: true
    )

    markdown.render(text.to_s).html_safe
  end

  def email_markdown(text)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      underline: true
    )

    markdown.render(text.to_s).html_safe
  end

  def flash_messages
    flash
      .to_hash
      .symbolize_keys
      .slice(:error, :alert, :notice, :success)
      .map { |name, msg| [name, Array(msg)] }
      .to_h
  end
end
