class BlogsController < ApplicationController
  before_action :find_blog, only: [ :edit, :update, :destroy ]

  def index
    @blogs = policy_scope(Blog)
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_param)
    authorize @blog
    if @blog.save
      redirect_to blogs_path
   else
      @blogs = Blog.all
      render :index     
   end
  end

  def edit
    @blogs = Blog.all
    authorize @blog
    render :index
  end

  def update
    if @blog.update
      redirect_to blogs_path 
    else
      @blogs = Blog.all
      render :index 
    end
  end

  def destroy
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
