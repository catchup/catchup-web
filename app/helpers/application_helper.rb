module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(
      CommentHTML,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      underline: true
    )

    markdown.render(text).html_safe
  end
end
