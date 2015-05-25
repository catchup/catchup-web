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

    markdown.render(emojify(text).to_s).html_safe
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

    markdown.render(emojify(text).to_s).html_safe
  end

  def emojify(content)
    return if content.blank?

    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        %(<img alt=":#$1:" src="#{image_url("emoji/#{emoji.image_filename}")}" style="vertical-align:middle; width: 20px; height: 20px" />)
      else
        match
      end
    end.html_safe
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
