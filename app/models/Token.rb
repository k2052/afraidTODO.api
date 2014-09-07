class Token
  include MongoMapper::Document

  key :access_token, String
  key :expires_at,   DateTime
  key :active,       Boolean
  key :application,  String

  before_create :generate_access_token
  before_create :set_expiration
  belongs_to :account

  def expired?
    DateTime.now >= self.expires_at
  end

  private
  
  def generate_access_token
    self.access_token = SecureRandom.hex unless self.access_token
  end

  def set_expiration
    self.expires_at = DateTime.now + 30
  end
end  
