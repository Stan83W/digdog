class Record < ApplicationRecord
  has_many :wants
  has_many :findings

  validates :discogs_id, uniqueness: true, presence: true

  def self.has?(discogs_id)
    !find_by_discogs_id(discogs_id).nil?
  end

  def self.find_by_discogs_id(discogs_id)
    find_by(discogs_id: discogs_id)
  end
end

# essai code search
# in model
  # include PgSearch
  # pg_search_scope :search_by_title, against: [ :title ]
# tag dispo
    # t.integer "discogs_id"
    # t.json "styles"
    # t.json "genres"
    # t.string "title"
    # t.json "artists"
    # t.json "labels"
    # t.integer "year"
