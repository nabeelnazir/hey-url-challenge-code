class UrlSerializer
  include JSONAPI::Serializer
  has_many :clicks
  attributes :created_at, :original_url, :short_url, :clicks_count
end
