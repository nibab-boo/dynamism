class Album < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  has_many :albumPhotos, before_add: :photos_count_within_bounds, dependent: :destroy

  private

  def photos_count_within_bounds
    return if albumPhotos.blank?
    raise PhotoLimitExceeded if albumPhotos.size >= 6
  end

  # accepts_nested_attributes_for :albumPhotos

  # validates :photos, limit: { max: 6 }
end
