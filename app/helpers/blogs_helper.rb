# frozen_string_literal: true

module BlogsHelper
  def format_content(blog)
    h(blog.content.gsub("\n", '<br>')) # rubocop:disable Rails/OutputSafety
  end
end
