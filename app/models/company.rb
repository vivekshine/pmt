require 'digest/sha1'

class Company < ActiveRecord::Base
  validates_presence_of :adminlastname, :adminfirstname, :adminlogin, :email, :name
  validates_uniqueness_of :adminlogin, :name, :email
  validates_numericality_of :credits, :greater_than_or_equal_to => 0

  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validate :password_non_blank

  def self.authenticate(adminlogin, password)
    company = self.find_by_adminlogin(adminlogin)
    if company
      expected_password = encrypted_password(password, company.salt)
      if company.hashed_password != expected_password
        company = nil
      end
    end
    company
  end

# 'password' is a virtual attribute
  def password
    @password
  end

  def password=(pwd)
    self.plainpwd = pwd
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Company.encrypted_password(self.password, self.salt)
   end

def after_destroy
   if Company.count.zero?
      raise "Can't delete last company"
   end
end



private
  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end	

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

end
