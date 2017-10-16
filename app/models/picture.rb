class Picture < ApplicationRecord
  validates :artist, presence: true
  validates :title, length: { in: 3..20 }
  validates :url, presence: true
  validates :url, uniqueness: true
  validates :url, format: { with: /\Ahttp/, message: "must start with 'http'" }
end
