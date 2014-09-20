require 'oat/adapters/json_api'

class UsersSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "users"
    link :self, href: '/users'
    collection :users, item, UserSerializer
  end
end
