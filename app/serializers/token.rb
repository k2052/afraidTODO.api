require 'oat/adapters/json_api'

class TokenSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "token"

    property :href,       "https://api.afraidTO.do/token/#{item.id}"
    property :id,           item.id
    property :access_token, item.access_token
    property :expires_at,   item.expires_at
    property :created_at, item.created_at
    property :updated_at, item.updated_at
  end
end