# frozen_string_literal: true

class BlogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_my_blog, only: %i[edit update destroy]
  before_action :require_premium, only: %i[create update]

  def index
    @blogs = Blog.search(params[:term]).published.default_order
  end

  def show
    @blog = Blog.find(params[:id])
    head :not_found if @blog.secret? && @blog.user != current_user
  end

  def new
    @blog = Blog.new
  end

  def edit; end

  def create
    @blog = current_user.blogs.new(blog_params)

    if @blog.save
      redirect_to blog_url(@blog), notice: 'Blog was successfully created.'
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to blog_url(@blog), notice: 'Blog was successfully updated.'
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @blog.destroy!

    redirect_to blogs_url, notice: 'Blog was successfully destroyed.', status: :see_other
  end

  private

  def set_my_blog
    @blog = current_user.blogs.find(params[:id])
  end

  def require_premium
    return unless params.dig(:blog, :random_eyecatch) == '1'

    head :bad_request unless current_user.premium?
  end

  def blog_params
    params.expect(blog: %i[title content secret random_eyecatch])
  end
end
