# frozen_string_literal: true

class Api::LikingsController < ApplicationController
  def create
    blog = Blog.published.find(params[:blog_id])
    current_user.likings.create!(blog:)
    head :ok
  end

  def destroy
    liking = current_user.likings.find(params[:id])
    liking.destroy!
    head :ok
  end
end
