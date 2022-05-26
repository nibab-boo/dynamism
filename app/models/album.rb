class Album < ApplicationRecord
  has_many_attached :photos

  validates :title, presence: true
  validates :photos, limit: { max: 6 }
end
