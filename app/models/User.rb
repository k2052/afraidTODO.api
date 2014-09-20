class User
  include MongoMapper::Document
  include MongoMapperExt::Archiver
  attr_accessor :password

  ##
  # Keys
  #

  ## Basic Details
  key :username, String
  key :name,     String
  key :provider, String, default: "password"
  key :uid,      String
  key :avatar,   String

  ## Authentication
  key :email,            String
  key :crypted_password, String

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
  validates_presence_of   :password,                   :if => :password_required
  validates_length_of     :password, :within => 4..40, :if => :password_required
  validates_presence_of   :email
  validates_length_of     :email, :within => 3..100
  validates_uniqueness_of :email, :case_sensitive => false
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :username

  ##
  # Callbacks
  # 

  after_create :create_token

  # Callbacks
  before_save :encrypt_password, :if => :password_required
  before_save :gen_username

  ##
  # Methods
  #
  def self.create_from_auth_hash(auth)
    create do |user|
      user.password = auth.password
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.username = auth.info.nickname
      user.avatar   = auth.image || "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}"
    end
  end

  def self.find_or_create_from_auth_hash(auth)
    return nil unless auth.provider.present? and auth.uid.present?
    user = first(:provider => auth.provider, :uid => auth.uid) 
    return user if user
    create_from_auth_hash auth
  end

  def create_token
    Token.create(user: self)
  end

  def gen_username
    if self[:username].blank?
      self[:username] = self.email
    end
  end


  ###
  ## Authentication

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate_with_email_pass(email, password)
    user = first(:email => /#{Regexp.escape(email)}/i) if email.present?
    user && user.has_password?(password) ? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password)
  end

  def password_required
    if self[:provider] == 'password'
      crypted_password.blank? || password.present?
    end
  end
end
