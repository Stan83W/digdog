class Record < ApplicationRecord
  has_many :wants, dependent: :destroy
  has_many :findings, dependent: :destroy

  validates :discogs_id, uniqueness: true, presence: true

  def self.has?(discogs_id)
    !find_by_discogs_id(discogs_id).nil?
  end

  def self.find_by_discogs_id(discogs_id)
    find_by(discogs_id: discogs_id)
  end
end
