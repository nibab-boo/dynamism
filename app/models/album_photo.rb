class AlbumPhoto < ApplicationRecord
  has_one_attached :photo
  belongs_to :album

  def image_url
    photo.url
  end
end
