# frozen_string_literal: true

class MyBlogsController < ApplicationController
  def index
    @blogs = current_user.blogs.default_order
  end
end
