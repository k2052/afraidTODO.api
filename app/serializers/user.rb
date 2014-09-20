require 'oat/adapters/json_api'

class UserSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "user"
    link :self, href: url

    property :name,   item.name
    property :email,  item.email
    property :avatar, item.avatar
    entities :tokens, item.tokens, TokenSerializer
  end

  def url
    "https://api.afraidTO.do/users/#{item.id}"
  end
end
