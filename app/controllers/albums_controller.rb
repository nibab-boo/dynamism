class AlbumsController < ApplicationController

  def index
    @albums = policy_scope(Album).includes(:albumPhotos)
    # p @albums
  end

  def new
    @album = Album.new
    authorize @album
  end

  def create
    @album = Album.new(album_param)
    @album.user = current_user
    @album.save
    params[:album][:albumPhotos]&.each do |blob|
      albumPhoto = AlbumPhoto.new(photo: blob)
      albumPhoto.album = @album
      albumPhoto.save
    end
    authorize @album
    redirect_to action: :index
  end

  def edit
    @album = Album.find(params[:id])
    authorize @album
  end

  def update
    @album = Album.find(params[:id])
    authorize @album
    @album.update(album_param)
    params[:album][:albumPhotos]&.each do |blob|
      return if @album.albumPhotos.count >= 6
      albumPhoto = AlbumPhoto.new(photo: blob)
      albumPhoto.album = @album
      albumPhoto.save
    end
    

    redirect_to action: :index
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
