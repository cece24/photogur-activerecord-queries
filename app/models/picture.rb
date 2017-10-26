class Picture < ApplicationRecord
  validates :artist, presence: { message: "Ahoy matey! Artist be missing "}
  validates :title, length: { in: 3..20 }
  validates :url, presence: true
  validates :url, uniqueness: true
  validates :url, format: { with: /\Ahttp/, message: "must start with 'http'" }

  belongs_to :user

  scope :older_than_1_month, -> { where("created_at < ?", Date.current.prev_month) }

  def self.pictures_created_in_year(year)
    Picture.where("created_at >= ? AND created_at <= ?", "#{ year }-01-01", "#{ year }-12-31")
  end
end
