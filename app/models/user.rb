class User < ApplicationRecord
    has_secure_password

    has_many :comments, dependent: :destroy
    has_many :reports, dependent: :destroy
    
    validates_presence_of :name, :email, :password_digest
end
