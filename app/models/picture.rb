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
end
