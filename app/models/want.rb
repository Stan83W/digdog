class Want < ApplicationRecord
  belongs_to :user
  belongs_to :record

  validates :user_id, presence: true #, uniqueness: { scope des users id discogs et/ou digog  }
  validates :record_id, presence: true
end
