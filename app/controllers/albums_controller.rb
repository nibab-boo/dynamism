class AlbumsController < ApplicationController

  def index
    @albums = policy_scope(Album)

    p @albums
  end

  def new
    @album = Album.new
    authorize @album
  end

  def create
    @album = Album.new(album_param)
    @album.user = current_user
    @album.save
    params[:album][:albumPhotos].each do |blob|
      albumPhoto = AlbumPhoto.new(photo: blob)
      albumPhoto.album = @album
      albumPhoto.save
    end
    authorize @album
    redirect_to :index
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def album_param
    params.require(:album).permit( :title )
  end

  def album_photos_param
    params.require(:album).permit( albumPhotos: [] )
  end
end
