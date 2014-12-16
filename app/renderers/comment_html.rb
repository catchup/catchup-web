# Public: Custom renderer for redcarpet that generates exact markup that we
# want in our comments.
#
# For full list methods that you can override see http://git.io/aZZMzw
class CommentHTML < Redcarpet::Render::HTML
  LIST_STYLE_TYPES = { ordered: 'decimal', unordered: 'disc' }

  def header(text, _)
    custom_paragraph(text)
  end

  def paragraph(text)
    custom_paragraph(text)
  end

  def list(contents, _)
    '<ul class="comment-list clearfix">'\
      "#{contents}"\
    '</ul>'
  end

  def list_item(text, list_type)
    list_style_type = LIST_STYLE_TYPES[list_type]
    style_attr = "style=\"list-style: #{list_style_type} !important;\""

    "<li class=\"comment-listitem\" #{style_attr}>"\
      "#{text}"\
    '</li>'
  end

  def codespan(code)
    "<code>#{code}</code>"
  end

  def block_code(code, _)
    '<div class="comment-text-container clearfix">'\
      "<pre>#{codespan(code)}</pre>"\
    '</div>'
  end

  def block_quote(quote)
    '<blockquote class="comment-blockquote clearfix">'\
      "#{quote}"\
    '</blockquote>'
  end

  private

  def custom_paragraph(text)
    '<div class="comment-text-container clearfix">'\
      "<p class=\"comment-text\">#{text}</p>"\
    '</div>'
  end
end
