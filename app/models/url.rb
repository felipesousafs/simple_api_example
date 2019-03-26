class Url < ApplicationRecord
  belongs_to :page

  validates :link, presence: true
end
