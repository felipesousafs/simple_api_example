class ContentResource < JSONAPI::Resource
  immutable

  attribute :text
  has_one :content_type
end