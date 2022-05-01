class Api::V1::BlogsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [ :index ]
  # before_action :find_blog, only: [:show, :update]
  def index
    @blogs = policy_scope(Blog)
    # Check if the domain is the real domain of user
    check_request_url(request)
    # Will render json.jbuilder by default if no errors with url
  end

  # def show; end

  # def update
  #   if @blog.update(blog_params)
  #     render :show
  #  else
  #    render_error
  #  end
  # end
  
  private 

  def check_request_url(request)
    
    # check for referrer
    if request.referrer.nil?
      render json: {error: "Please, provide referrerPolicy. Check #{profile_url} for your api information."}, status: :unauthorized
    else
      user_domain = current_user.domain.sub(/https?:\/\//, "")
      # INCASE test mode is on
      if current_user.test
        should_be_url = "(localhost:\\d{4,5}\/?|#{user_domain})"
        error_message = "#{request.referrer} is not the correct url for test. Please, try changing using localhost instead of your ip address.( Eg. http://localhost:3000 )"
      else   # INCASE test mode is off
        should_be_url = user_domain
        error_message = "#{request.referrer} is not the correct domain of the user."
      end

      # If check doesnot match up, Render this json to user.
      unless /(https?:\/\/)?#{should_be_url}(^(.\w*)|\/\w*)?/.match?(request.referrer)
        render :json => {
          error: error_message
        }, status: :unauthorized
      end
    end
  end
  
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