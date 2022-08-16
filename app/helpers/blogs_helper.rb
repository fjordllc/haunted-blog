# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    simple_format(html_escape(blog.content))
    # 別解
    # safe_join(blog.content.split("\n"), tag.br)
  end
end
