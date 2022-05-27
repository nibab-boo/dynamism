class Album < ApplicationRecord

  validates :title, presence: true
  has_many :albumPhoto



  # validates :photos, limit: { max: 6 }
end
