# frozen_string_literal: true

class BlogsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_blog, only: %i[show edit update destroy]
  before_action :authorize_user, only: %i[edit update destroy]
  before_action :authorize_random_eyecatch, only: %i[create update]

  def index
    @blogs = Blog.search(params[:term]).published.default_order
  end

  def show
    if @blog.secret && @blog.user != current_user
      render status: :not_found, html: helpers.tag.strong('他ユーザーの秘密のブログは見れません')
    end
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

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def authorize_user
    return if @blog.user == current_user

    render status: :not_found, html: helpers.tag.strong('編集権限がありません')
  end

  def authorize_random_eyecatch
    return if current_user.premium || !blog_params[:random_eyecatch]

    head :bad_request
  end

  def blog_params
    params.expect(blog: %i[title content secret random_eyecatch])
  end
end
