class AlbumsController < ApplicationController

  def index
    @album = policy_scope(Album)
  end

  def new
    @album = Album.new
    authorize @album
  end

  def create
    
    byebug

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def album_params
    params.require(:album).permit( :title, :photos )
  end
end
