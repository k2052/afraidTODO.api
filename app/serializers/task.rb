require 'oat/adapters/json_api'

class TaskSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "tasks"
    property :href,       "https://api.afraidTO.do/tasks/#{item.id}"
    property :id,         item.id
    property :text,       item.text
    property :done,       item.done
    property :created_at, item.created_at
    property :updated_at, item.updated_at
  end
end
