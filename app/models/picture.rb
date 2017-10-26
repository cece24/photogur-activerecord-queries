class Picture < ApplicationRecord
  validates :artist, presence: { message: "Ahoy matey! Artist be missing "}
  validates :title, length: { in: 3..20 }
  validates :url, presence: true
  validates :url, uniqueness: true
  validates :url, format: { with: /\Ahttp/, message: "must start with 'http'" }

  belongs_to :user

  def self.older_than_1_month
    Picture.where("created_at < ?", Date.current.prev_month)
  end

  def self.pictures_created_in_year(year)
    # find all pictures where created_at year is == year
    Picture.where("created_at >= ? AND created_at <= ?", "#{ year }-01-01", "#{ year }-12-31")
  end
end
