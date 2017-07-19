api_mime_types = %W(
  application/vnd.api+json
  text/x-json
  application/json
)

Mime::Type.register 'application/vnd.api+json', :json, api_mime_types

ActiveModelSerializers.config.adapter = :json_api

module BSON
  class ObjectId
    alias :to_json :to_s
    alias :as_json :to_s
  end
end
