# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    simple_format(blog.content, {}, sanitize: true)
  end
end
