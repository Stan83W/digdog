class Record < ApplicationRecord

  def self.has?(discogs_id)
    !find_by_discogs_id(discogs_id).nil?
  end

  def find_by_discogs_id(discogs_id)
    Record.find_by(discogs_id: discogs_id)
  end

  def wanted?

  end

  def found?

  end

end
