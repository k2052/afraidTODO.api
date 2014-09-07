require 'oat/adapters/json_api'

class TaskSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "tasks"
    property :id, item.id
    property :title, item.title
  end
end
