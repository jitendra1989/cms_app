class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
   has_many :comments
  before_save :encrypt_password
  before_update :encrypt_password

   def encrypt_password
    if encrypted_password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(encrypted_password, salt)
    end
  end


   def self.authenticateUsersWithSchool(email, password)

    user = find_by_email(email)
 
    if user && user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

       
end
