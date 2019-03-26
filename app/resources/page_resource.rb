class PageResource < JSONAPI::Resource
  attribute :link

  has_many :urls
  has_many :contents
end