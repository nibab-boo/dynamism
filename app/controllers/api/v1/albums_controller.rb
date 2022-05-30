class Api::V1::AlbumsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [:index, :show]

  def index
    @albums = policy_scope(Album).includes(:albumPhotos)
    # Check if the domain is the real domain of user
    check_request_url(request)
    # Will render json.jbuilder by default if no errors with url
  end

  def show
    @album = Album.find_by(title: params[:id])
    authorize @album

    check_request_url(request)
  end



  private 

  def check_request_url(request)
    
    # check for referrer
    if request.referrer.nil?
      render json: {error: "Please, provide referrerPolicy. Check #{profile_url} for your api information."}, status: :unauthorized
    else
      user_domain = current_user.domain.sub(/https?:\/\//, "")
      # INCASE test mode is on
      if current_user.test
        should_be_url = "((localhost|\\b\\d{1,3}\.\\d{1,3}\.\\d{1,3}\.\\d{1,3}\\b):\\d{4,5}\/?|#{user_domain})"
        error_message = "#{request.referrer} is not the correct url for test. Please, try using local server ( Eg. localhost:3000 )."
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
end
