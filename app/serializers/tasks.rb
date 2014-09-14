require 'oat/adapters/json_api'

class TasksSerializer < Oat::Serializer
  adapter Oat::Adapters::JsonAPI

  schema do
    type "tasks"
    link :self, href: '/tasks'
    collection :tasks, item, TaskSerializer
  end
end
