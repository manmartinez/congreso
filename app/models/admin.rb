class Admin < ActiveRecord::Base
  SALT = 'c0ngr350!'

  validates :name, :email, :encrypted_password, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true, if: :needs_password?

  # True if user needs to assign a password
  def needs_password?
    self.new_record? || !self.password.blank?
  end

  # Returns a user with corresponding email and password or nil
  def self.authenticate(email, pwd)
    user = self.find_by(email: email)
    if user
      user = nil unless user.encrypted_password.eql? self.encrypt(pwd, SALT)
    end
    user
  end

  def change_password(current_password, new_password)
    if self.class.encrypt(current_password, SALT).eql? self.encrypted_password
      self.password = new_password
      self.save
    else
      errors.add(:current_password, "no coincide con el password actual")
      false
    end
  end
  
  # Virtual attribute that corresponds to plain-text password
  def password
    @password
  end
  
  # Virtual attribute that corresponds to plain-text password
  def password=(pwd)
    @password = pwd
    self.encrypted_password = self.class.encrypt(pwd,SALT) unless pwd.blank?
  end
  
  
  protected
    
    def self.encrypt(*args)      
      Digest::SHA1.hexdigest(args.join)
    end
end
