class Api::LikingUsersController < ApplicationController
  before_action :authenticate_user!

  def index
    blog = Blog.find(params[:blog_id])
    users = blog.liking_users.order(:id)
    my_liking = blog.likings.find_by(user: current_user)
    destroy_path = my_liking ? api_blog_liking_path(blog, my_liking) : nil

    render json: { users: users, destroy_path: destroy_path }
  end
end
