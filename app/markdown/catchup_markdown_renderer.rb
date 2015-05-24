# Public: Custom renderer for redcarpet.
#
# For full list methods that you can override see http://git.io/aZZMzw
class CatchupMarkdownRenderer < Redcarpet::Render::HTML
  def block_code(code, _)
    "<pre class='md-block-code'><code>#{code}</code></pre>"
  end

  def block_quote(quote)
    "<blockquote class='md-block-quote'>#{quote}</blockquote>"
  end

  def list(contents, list_type)
    tag = "#{list_type.to_s.first}l"
    "<#{tag} class='md-list-#{list_type} clearfix'>\
    #{contents}\
    </#{tag}>"
  end

  def list_item(text, list_type)
    "<li class='md-list-item-#{list_type}'>#{text}</li>"
  end

  def paragraph(text)
    "<p class='md-text'>#{text}</p>"
  end
end
