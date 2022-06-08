class User < ApplicationRecord
  attr_accessor :remember_token, :remember_me, :activation_token

  before_create :create_atrivation_digest
  before_save :downcase_email
  validates :name, presence: true, length: {minimum:5, maximum:30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {minimum:9, maximum:30},
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: true
  
  has_secure_password
  validates :password, presence: true, length: {minimum:6}

  def downcase_email
    self.email = email.downcase 
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget 
    update_attribute(:remember_digest, nil)
  end 

  class << self

    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end


    
  end

  private 
    def create_atrivation_digest
      self.activation_token = User.new_token
      self.activation_digest =User.digest(activation_token)
      
    end
end

#второе да там на хероку но он не работает на этом приложении. вот на первом работает хероку
#нее, у меня два приложения на сессиях