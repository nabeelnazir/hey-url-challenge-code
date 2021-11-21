class ClickSerializer
  include JSONAPI::Serializer
  attributes :url_id, :browser, :platform
end
