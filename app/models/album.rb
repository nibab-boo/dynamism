class Album < ApplicationRecord
  has_many_attached :photos

  validates :photos, limit: { max: 6 }
end
