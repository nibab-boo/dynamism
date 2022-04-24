class UsersController < ApplicationController

  def profile
    @user_name = current_user.email.match(/(\w+)@\w+.com/)[1]
    @user = current_user
    authorize @user
  end

end
