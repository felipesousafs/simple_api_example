class Content < ApplicationRecord
  belongs_to :page
  belongs_to :content_type

  validates :text, presence: true
end
