class MyBlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @blogs = current_user.blogs.default_order
  end
end
