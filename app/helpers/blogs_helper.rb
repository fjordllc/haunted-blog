# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    html_escape(blog.content).gsub("\n", '<br>').html_safe
  end
end
