# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    sanitize(
      blog.content.gsub("\n", '<br>'),
      tags: ['br']
    )
  end
end
