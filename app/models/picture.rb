class Picture < ApplicationRecord
  validates :artist, presence: true
end
