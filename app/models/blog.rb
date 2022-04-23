class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  validates :title, :description, presence: true  
end
