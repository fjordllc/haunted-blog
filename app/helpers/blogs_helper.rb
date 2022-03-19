module BlogsHelper
  def format_content(blog)
    blog.content.gsub("\n", '<br>').html_safe
  end
end
