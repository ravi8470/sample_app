class User < ActiveRecord::Base
  before_save { self.email = email.downcase } # or "before_save { email.downcase! }"
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } #while checking
  # for uniqueness up and downcases should be considered the same. So emails like A@x.com and a@x.com are same. there's no need to
  # write true for uniqueness, rails infers this because we gave a condition to it.
  has_secure_password
  validates :password, length: { minimum: 6 }
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
