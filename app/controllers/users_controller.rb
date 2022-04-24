class UsersController < ApplicationController

  def profile
    @user_name = current_user.email.match(/(\w+)@\w+.com/)[1]
    @user = current_user
    authorize @user
  end

  def reset_api
    @user = current_user
    authorize @user
    @user.authentication_token = nil
    if  @user.save
      respond_to do |f|
        f.html { redirect_to profile_path, :notice => "Api Key successfully reset." }
        f.js
      end
   else
      redirect_to profile_path, :notice => "Api key could not be reset.", :alert => current_user.errors.full_message
   end
  end

end
