class Album < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :albumPhotos
  before_save :photos_count_within_bounds

  private

  def photos_count_within_bounds
    return if albumPhotos.blank?
    errors.add("Too many photos") if photos.size > 10
  end

  accepts_nested_attributes_for :albumPhotos

  # validates :photos, limit: { max: 6 }
end
