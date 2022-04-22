class Api::V1::BlogsController < Api::V1::BaseController
  def index
    @blogs = policy_scope(Blog)
  end
  
  def show
    @blog = Blog.find(params[:id])
    authorize @blog
  end

end