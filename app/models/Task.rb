class Task
  include MongoMapper::Document

  key :title, String

  validates_presence_of :title
  attr_accessible :id, :title
end
