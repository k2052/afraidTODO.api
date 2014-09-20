require 'oat/adapters/json_api'

class TokensSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "tokens"
    link :self, href: '/tokens'
    collection :tokens, item, TokenSerializer
  end
end
