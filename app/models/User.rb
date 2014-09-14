class User
  include MongoMapper::Document
  include OmniAuth::Identity::Models::MongoMapper

  ##
  # Keys
  #

  ## Basic Details
  key :username,   String
  key :first_name, String
  key :last_name,  String
  key :read_tos,   Boolean, :default => false

  ## Access
  key :role,  String, :default => :free
  key :roles, Array

  ## Authentication
  key :email,           String
  key :password_digest, String

  ##
  # Key settings
  #
  timestamps!

  ##
  # Associations
  #
  many :tokens
  many :tasks
  
  ##
  # Validations
  #
  validates_presence_of   :email, :role, :username
  validates_length_of     :email, :within => 3..100
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of     :role,  :with => /[A-Za-z]/
  validates_uniqueness_of :username

  ##
  # Callbacks
  # 

  after_create :create_token

  ##
  # Methods
  #
  def name
    return "#{self.first_name}, #{self.last_name}" unless self.first_name.nil?
    return ''
  end
 
  def name=(n)
    n = n.split(",").join(" ").split(" ").uniq
    self.first_name = n[0] if n.length > 0
    self.last_name = n[1] if n.length >= 1
  end

  def role=(role)
    self[:role] = role
    self.roles << role unless self.roles.include?(role)
  end

  def role?(role)
    return true if self.role.to_sym == role.to_sym
    return self.roles.include?(role.to_sym)
  end

  def self.with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.username = auth.info.nickname
      user.avatar   = auth.extra.raw_info.avatar_url || "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}"
    end
  end

  def create_token
    Token.create(user: self)
  end
end
