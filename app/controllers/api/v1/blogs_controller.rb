class Api::V1::BlogsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :index ]
  # before_action :find_blog, only: [:show, :update]
  def index
    @blogs = policy_scope(Blog)
  end
  
  # def show; end

  # def update
  #   if @blog.update(blog_params)
  #     render :show
  #  else
  #    render_error
  #  end
  # end
  
  # private 
  
  # def find_blog
  #   @blog = Blog.find(params[:id])
  #   authorize @blog
  # end

  # def blog_params
  #   params.require(:blog).permit(:title, :description, :link)
  # end

  # def render_error
  #   render json: { errors: @blog.errors.full_messages }, status: :unprocessable_entity
  # end

end