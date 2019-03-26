class ContentTypeResource < JSONAPI::Resource
  immutable

  attribute :name
  has_many :contents
end