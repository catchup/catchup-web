module ApplicationHelper
  def comment_markdown(text)
    markdown = Redcarpet::Markdown.new(
      MarkdownToHTMLComment,
      fenced_code_blocks: true,
      autolink: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      underline: true
    )

    markdown.render(text).html_safe
  end
end
