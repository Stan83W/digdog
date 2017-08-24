class Want < ApplicationRecord
  belongs_to :user
  belongs_to :record

  validates :user_id, presence: true
  validates :record_id, presence: true, uniqueness: { scope: :user_id }


end
