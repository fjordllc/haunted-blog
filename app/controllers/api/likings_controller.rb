class Api::LikingsController < ApplicationController
  before_action :authenticate_user!

  def create
    blog = Blog.find(params[:blog_id])
    current_user.likings.create!(blog: blog)
  end

  def destroy
    liking = Liking.find(params[:id])
    liking.destroy!
  end
end
