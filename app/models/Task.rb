class Task
  include MongoMapper::Document

  ##
  # Keys
  ##

  key :text, String
  key :done, Boolean, default: false

  ## 
  # Key Settings
  ##
  validates_presence_of :text
  attr_accessible :id, :text, :done
  timestamps!

  ##
  # Associations
  ##
  belongs_to :user

  def do
  	self[:done] = true
  end

  def do!
  	self[:done] = true
	  @save
  end
end
