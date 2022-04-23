class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :title, :description, presence: true

  def image_url
    photo.url
  end
end
