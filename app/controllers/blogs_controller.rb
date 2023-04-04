# frozen_string_literal: true

class BlogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_blog, only: %i[show edit update destroy]
  before_action :authenticate_author!, only: %i[edit update destroy]
  before_action :authenticate_for_secret_blog!, only: %i[show edit update destroy]

  def index
    @blogs = Blog.search(params[:term]).published.default_order
  end

  def show; end

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = current_user.blogs.new(blog_params)

    if @blog.save
      redirect_to blog_url(@blog), notice: 'Blog was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_url(@blog), notice: 'Blog was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy!

    redirect_to blogs_url, notice: 'Blog was successfully destroyed.', status: :see_other
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def authenticate_author!
    raise ActiveRecord::RecordNotFound unless @blog.owned_by?(current_user)
  end

  def authenticate_for_secret_blog!
    raise ActiveRecord::RecordNotFound if !@blog.owned_by?(current_user) && @blog.secret
  end

  def blog_params
    checked_params = params.require(:blog).permit(:title, :content, :secret, :random_eyecatch)
    checked_params[:random_eyecatch] = false unless current_user.premium
    checked_params
  end
end
