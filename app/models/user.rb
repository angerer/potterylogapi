class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :works, foreign_key: :created_by
  
  # Validations
  validates_presence_of :email, :firstname, :lastname, :password_digest
end
