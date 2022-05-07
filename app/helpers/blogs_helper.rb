# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    blog.content.gsub("\n", '<br>')
  end
end
