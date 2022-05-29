class AlbumPhotosController < ApplicationController

  def destroy
    @album = Album.find(params[:album_id])
    @albumPhoto = AlbumPhoto.find(params[:id])
    authorize @albumPhoto
    if @album && @albumPhoto
      @albumPhoto.destroy
    end

    redirect_to albums_path
  end

  def create
    @album = Album.find(params[:album_id])
    authorize @album
    if @album
      params[:albumPhoto][:photos]&.each do |blob|
        return if @album.albumPhotos.count >= 6
        albumPhoto = AlbumPhoto.new(photo: blob)
        albumPhoto.album = @album
        albumPhoto.save
      end
    end

    redirect_to albums_path
  end
end
