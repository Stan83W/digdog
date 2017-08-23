class Record < ApplicationRecord

  validates :discogs_id, uniqueness: true, presence: true

  def self.has?(discogs_id)
    !find_by_discogs_id(discogs_id).nil?
  end

  def wanted?

  end

  def found?

  end

end
