module ApplicationHelper
  def convert_to_html(data)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    markdown.render(data)
  end
end
