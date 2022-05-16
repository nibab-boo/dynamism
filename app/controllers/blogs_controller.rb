class BlogsController < ApplicationController
  before_action :find_blog, only: [ :edit, :update, :destroy ]

  def index
    @blogs = policy_scope(Blog).order(id: :asc)
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_param)
    @blog.user = current_user
    authorize @blog
    if @blog.save
      redirect_to blogs_path
    else
      @blogs = current_user.blogs.order(id: :asc)
      render :index     
   end
  end

  def edit
    @blogs = current_user.blogs.order(id: :asc)
    authorize @blog
    render :index
  end

  def update
    authorize @blog
    if @blog.update(blog_param)
      redirect_to blogs_path 
    else
      @blogs = current_user.blogs.order(id: :asc)
      render :index 
    end
  end

  def destroy
    authorize @blog
    @blog.destroy
    redirect_to blogs_path
  end

  private

  def blog_param
    params.require(:blog).permit(:title, :description, :link, :photo)
  end

  def find_blog
    @blog = Blog.find(params[:id])
  end
end
