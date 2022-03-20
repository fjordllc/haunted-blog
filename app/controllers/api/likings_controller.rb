class Api::LikingsController < ApplicationController
  def create
    blog = Blog.published.find(params[:blog_id])
    current_user.likings.create!(blog: blog)
  end

  def destroy
    liking = current_user.likings.find(params[:id])
    liking.destroy!
  end
end
