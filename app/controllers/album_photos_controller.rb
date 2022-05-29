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
end
