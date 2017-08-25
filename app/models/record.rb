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


  # test search

def self.search(search)
  if search
    find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end



end
