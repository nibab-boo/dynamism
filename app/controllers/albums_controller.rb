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
    authorize @album
    params[:album][:albumPhotos]&.each do |blob|
      return if @album.albumPhotos.count >= 6
      albumPhoto = AlbumPhoto.new(photo: blob)
      albumPhoto.album = @album
      albumPhoto.save
    end
    redirect_to action: :index
  end

  def edit
    @album = Album.find(params[:id])
    authorize @album
  end

  def update
    byebug
    @album = Album.find(params[:id])
    authorize @album
    if @album.update(album_param)  
      render json: { title: @album.title }
    else
      error_json = {
        errors: @album.errors.full_messages
      }
      @album.reload
      error_json[:title] = @album.title
      render json: error_json
    end
    # redirect_to action: :index
  end

  def destroy
    @album = Album.find(params[:id])
    authorize @album

    @album.destroy
    redirect_to action: :index
  end

  private

  def album_param
    params.require(:album).permit( :title )
  end

  def album_photos_param
    params.require(:album).permit( albumPhotos: [] )
  end
end
